//
//  Gatepass
//  blocs_test.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/auth/models/data/account_session.dart';
import 'package:gatepass/auth/models/data/resident.dart';
import 'package:gatepass/auth/models/data/site.dart';
import 'package:gatepass/auth/models/repos/abs/auth_repository.dart';
import 'package:gatepass/auth/state/session/session_bloc.dart';
import 'package:gatepass/backup/models/repos/abs/backup_repository.dart';
import 'package:gatepass/backup/models/repos/abs/recovery_phrase_repository.dart';
import 'package:gatepass/backup/state/backup/backup_bloc.dart';
import 'package:gatepass/core/models/data/application_error.dart';
import 'package:gatepass/core/models/data/request_status.dart';
import 'package:gatepass/invites/models/data/invite.dart';
import 'package:gatepass/invites/models/data/invite_draft.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:gatepass/invites/models/repos/abs/invite_archive_repository.dart';
import 'package:gatepass/invites/models/repos/abs/invite_repository.dart';
import 'package:gatepass/invites/state/invites/invites_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuth extends Mock implements AuthRepository {}

class MockInvites extends Mock implements InviteRepository {}

class MockArchive extends Mock implements InviteArchiveRepository {}

class MockBackup extends Mock implements BackupRepository {}

class MockPhrases extends Mock implements RecoveryPhraseRepository {}

const account = AccountSession(
  resident: Resident(id: 'host', name: 'Tariro', phone: '', email: ''),
  site: Site(id: 'site', name: 'Estate', unit: '', area: ''),
);

Invite invite(String id, {InviteStatus status = InviteStatus.active}) => Invite(
  id: id,
  siteId: 'site',
  visitorName: 'Visitor $id',
  from: DateTime(2026, 10, 19, 9),
  until: DateTime(2099),
  status: status,
  code: 'C$id',
  link: '',
  createdAt: DateTime(2026, 10, 19, 8),
);

void main() {
  setUpAll(() {
    registerFallbackValue(<Invite>[]);
    registerFallbackValue(
      InviteDraft(visitorName: '', from: DateTime(0), until: DateTime(0)),
    );
  });

  group('SessionBloc', () {
    late MockAuth auth;
    setUp(() => auth = MockAuth());

    blocTest<SessionBloc, SessionState>(
      'restores a stored session',
      build: () {
        when(auth.restoreSession).thenAnswer((_) async => const Right(account));
        return SessionBloc(auth);
      },
      act: (bloc) => bloc.add(const SessionEvent.started()),
      expect: () => [
        const SessionState.restoring(),
        const SessionState.signedIn(account: account),
      ],
    );

    blocTest<SessionBloc, SessionState>(
      'signs out when nothing is stored or the restore fails',
      build: () {
        when(auth.restoreSession).thenAnswer(
          (_) async =>
              const Left(ApplicationError(code: ApplicationErrorCode.timeout)),
        );
        when(auth.signOut).thenAnswer((_) async => const Right(unit));
        return SessionBloc(auth);
      },
      act: (bloc) => bloc
        ..add(const SessionEvent.started())
        ..add(const SessionEvent.signOutRequested()),
      expect: () => [
        const SessionState.restoring(),
        const SessionState.signedOut(),
      ],
      verify: (_) => verify(auth.signOut).called(1),
    );
  });

  group('InvitesBloc', () {
    late MockInvites invites;
    late MockArchive archive;

    setUp(() {
      invites = MockInvites();
      archive = MockArchive();
      when(() => archive.save(any(), any())).thenAnswer(
        (_) async => const Right(unit),
      );
    });

    blocTest<InvitesBloc, InvitesState>(
      'shows the archive, then merges ATG and saves',
      build: () {
        when(() => archive.load('host')).thenAnswer(
          (_) async => Right([invite('old'), invite('a')]),
        );
        when(() => invites.fetchInvites('site')).thenAnswer(
          (_) async => Right([invite('a').copyWith(code: ''), invite('b')]),
        );
        return InvitesBloc(invites, archive);
      },
      act: (bloc) => bloc.add(const InvitesEvent.started(account: account)),
      verify: (bloc) {
        final state = bloc.state;
        expect(state.loaded, isTrue);
        expect(state.refresh, const RequestStatus<Unit>.succeeded(unit));
        expect(state.invites.map((i) => i.id).toSet(), {'old', 'a', 'b'});
        // A short list is all ATG has: a missing live invite was revoked.
        expect(state.inviteById('old')?.status, InviteStatus.revoked);
        // Details only the phone knew are kept.
        expect(state.inviteById('a')?.code, 'Ca');
        expect(state.changeRevision, 1);
        verify(() => archive.save('host', any())).called(1);
      },
    );

    blocTest<InvitesBloc, InvitesState>(
      'a failed refresh keeps the archive and reports the error',
      build: () {
        when(() => archive.load('host')).thenAnswer(
          (_) async => Right([invite('a')]),
        );
        when(() => invites.fetchInvites('site')).thenAnswer(
          (_) async => const Left(
            ApplicationError(code: ApplicationErrorCode.connection),
          ),
        );
        return InvitesBloc(invites, archive);
      },
      act: (bloc) => bloc.add(const InvitesEvent.started(account: account)),
      verify: (bloc) {
        expect(bloc.state.invites, [invite('a')]);
        expect(
          bloc.state.refresh,
          const RequestStatus<Unit>.failed(
            ApplicationError(code: ApplicationErrorCode.connection),
          ),
        );
        verifyNever(() => archive.save(any(), any()));
      },
    );

    blocTest<InvitesBloc, InvitesState>(
      'create adds the invite, revoke keeps its details',
      build: () {
        when(() => invites.createInvite('site', any())).thenAnswer(
          (_) async => Right(invite('new')),
        );
        when(() => invites.revokeInvite('new')).thenAnswer(
          (_) async => const Right(unit),
        );
        return InvitesBloc(invites, archive);
      },
      seed: () => const InvitesState(
        accountId: 'host',
        siteId: 'site',
        loaded: true,
      ),
      act: (bloc) async {
        bloc.add(
          InvitesEvent.createRequested(
            requestId: 'r1',
            draft: InviteDraft(
              visitorName: 'Visitor new',
              from: DateTime(2026),
              until: DateTime(2026),
            ),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const InvitesEvent.revokeRequested(requestId: 'r2', inviteId: 'new'),
        );
      },
      verify: (bloc) {
        final state = bloc.state;
        expect(state.requests['r1'], RequestStatus.succeeded(invite('new')));
        expect(state.revokes['r2'], const RequestStatus<Unit>.succeeded(unit));
        expect(state.invites.single.status, InviteStatus.revoked);
        expect(state.invites.single.code, 'Cnew');
        expect(state.changeRevision, 2);
      },
    );

    blocTest<InvitesBloc, InvitesState>(
      'an adopted backup is saved without counting as a change',
      build: () => InvitesBloc(invites, archive),
      seed: () => const InvitesState(accountId: 'host', siteId: 'site'),
      act: (bloc) => bloc.add(
        InvitesEvent.backupAdopted(accountId: 'host', invites: [invite('x')]),
      ),
      verify: (bloc) {
        expect(bloc.state.invites, [invite('x')]);
        expect(bloc.state.changeRevision, 0);
        verify(() => archive.save('host', [invite('x')])).called(1);
      },
    );
  });

  group('BackupBloc', () {
    late MockBackup backup;
    late MockPhrases phrases;

    setUp(() {
      backup = MockBackup();
      phrases = MockPhrases();
      when(backup.isOn).thenAnswer((_) async => const Right(true));
      when(() => backup.sync(any())).thenAnswer(
        (call) async => Right([
          ...call.positionalArguments.first as List<Invite>,
          invite('remote'),
        ]),
      );
    });

    blocTest<BackupBloc, BackupState>(
      'waits for the archive, then debounces later changes into one sync',
      build: () => BackupBloc(backup, phrases),
      act: (bloc) async {
        bloc.add(const BackupEvent.started(accountId: 'host'));
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(BackupEvent.changed(invites: [invite('a')]));
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc
          ..add(BackupEvent.changed(invites: [invite('a'), invite('b')]))
          ..add(
            BackupEvent.changed(
              invites: [invite('a'), invite('b'), invite('c')],
            ),
          );
      },
      wait: const Duration(milliseconds: 2300),
      verify: (bloc) {
        // Nothing before the archive loaded, which would drop invites only
        // this phone has.
        verifyNever(() => backup.sync([]));
        // The archive syncs at once; of the quick changes, only the last.
        verify(() => backup.sync([invite('a')])).called(1);
        verifyNever(() => backup.sync([invite('a'), invite('b')]));
        verify(
          () => backup.sync([invite('a'), invite('b'), invite('c')]),
        ).called(1);
        expect(bloc.state.merged?.map((i) => i.id), ['a', 'b', 'c', 'remote']);
        expect(bloc.state.mergedRevision, 2);
        expect(bloc.state.lastBackup, isNotNull);
      },
    );

    blocTest<BackupBloc, BackupState>(
      'a mistyped phrase fails before any restore',
      build: () {
        when(() => phrases.parse('nope')).thenAnswer(
          (_) async => const Left(
            ApplicationError(code: ApplicationErrorCode.phraseInvalid),
          ),
        );
        return BackupBloc(backup, phrases);
      },
      act: (bloc) =>
          bloc.add(const BackupEvent.restoreRequested(phrase: 'nope')),
      verify: (bloc) {
        expect(
          bloc.state.actions.values.single,
          const RequestStatus<Unit>.failed(
            ApplicationError(code: ApplicationErrorCode.phraseInvalid),
          ),
        );
        verifyNever(() => backup.restore(any(), any()));
      },
    );
  });
}
