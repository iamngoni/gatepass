// Gatepass — app_harness.dart. Created 2026-10-19.
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/auth/models/data/account_session.dart';
import 'package:gatepass/auth/models/data/cloud_identity.dart';
import 'package:gatepass/auth/models/data/otp_channel.dart';
import 'package:gatepass/auth/models/data/resident.dart';
import 'package:gatepass/auth/models/data/site.dart';
import 'package:gatepass/auth/models/repos/abs/auth_repository.dart';
import 'package:gatepass/auth/state/session/session_bloc.dart';
import 'package:gatepass/auth/state/sign_in/sign_in_bloc.dart';
import 'package:gatepass/backup/models/repos/abs/backup_repository.dart';
import 'package:gatepass/backup/models/repos/abs/recovery_phrase_repository.dart';
import 'package:gatepass/backup/state/backup/backup_bloc.dart';
import 'package:gatepass/core/models/data/application_error.dart';
import 'package:gatepass/core/state/appearance/appearance_bloc.dart';
import 'package:gatepass/injection.dart';
import 'package:gatepass/invites/models/data/invite.dart';
import 'package:gatepass/invites/models/data/invite_draft.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:gatepass/invites/models/repos/abs/invite_archive_repository.dart';
import 'package:gatepass/invites/models/repos/abs/invite_repository.dart';
import 'package:gatepass/invites/state/invites/invites_bloc.dart';
import 'package:gatepass/notifications/models/data/app_notification.dart';
import 'package:gatepass/notifications/models/repos/abs/notification_repository.dart';
import 'package:gatepass/notifications/state/notifications/notifications_bloc.dart';
import 'package:gatepass/providers.dart';

const testAccount = AccountSession(
  resident: Resident(id: 'r', name: 'Resident', phone: '', email: ''),
  site: Site(id: 's', name: 'Estate', unit: '', area: ''),
);

/// ATG in memory: sign-in, invites and notifications, recording what the
/// app asked for.
class FakeGate
    implements AuthRepository, InviteRepository, NotificationRepository {
  FakeGate({this.account = testAccount, List<Invite>? invites})
    : invites = invites ?? [];

  final AccountSession account;
  final List<Invite> invites;
  List<AppNotification> notifications = [];

  /// The code ATG gives each new invite.
  String newCode = 'ATGM2UAZALP0';

  /// Completes the launch restore; null means nothing was stored.
  final restore = Completer<AccountSession?>();
  final codeRequests = <(String, OtpChannel)>[];
  final drafts = <InviteDraft>[];
  final revoked = <String>[];

  @override
  Future<Either<ApplicationError, AccountSession?>> restoreSession() async =>
      Right(await restore.future);

  @override
  Future<Either<ApplicationError, Unit>> requestCode(
    String phone, {
    OtpChannel channel = OtpChannel.sms,
  }) async {
    codeRequests.add((phone, channel));
    return const Right(unit);
  }

  @override
  Future<Either<ApplicationError, AccountSession>> signIn({
    required String phone,
    required String code,
  }) async => Right(account);

  @override
  Future<Either<ApplicationError, CloudIdentity>> cloudIdentity() async =>
      const Right(CloudIdentity(uid: 'uid', idToken: 'token'));

  @override
  Future<Either<ApplicationError, Unit>> signOut() async => const Right(unit);

  @override
  Future<Either<ApplicationError, List<Invite>>> fetchInvites(
    String siteId,
  ) async => Right([...invites]);

  @override
  Future<Either<ApplicationError, Invite>> createInvite(
    String siteId,
    InviteDraft draft,
  ) async {
    drafts.add(draft);
    final invite = Invite(
      id: 'new${drafts.length}',
      siteId: siteId,
      visitorName: draft.visitorName,
      serviceId: draft.serviceId,
      phone: draft.phone,
      vehicleReg: draft.vehicleReg,
      from: draft.from,
      until: draft.until,
      status: InviteStatus.active,
      code: newCode,
      link: 'https://new.atthegate.biz/visitor/shared?code=$newCode',
      createdAt: DateTime.now(),
    );
    invites.add(invite);
    return Right(invite);
  }

  @override
  Future<Either<ApplicationError, Unit>> revokeInvite(String inviteId) async {
    revoked.add(inviteId);
    return const Right(unit);
  }

  @override
  Future<Either<ApplicationError, List<AppNotification>>> fetchNotifications(
    String siteId,
  ) async => Right([...notifications]);

  @override
  Future<Either<ApplicationError, Unit>> markRead(Iterable<String> ids) async =>
      const Right(unit);
}

class MemoryArchive implements InviteArchiveRepository {
  final byAccount = <String, List<Invite>>{};

  @override
  Future<Either<ApplicationError, List<Invite>>> load(String accountId) async =>
      Right(byAccount[accountId] ?? const []);

  @override
  Future<Either<ApplicationError, Unit>> save(
    String accountId,
    List<Invite> invites,
  ) async {
    byAccount[accountId] = [...invites];
    return const Right(unit);
  }
}

/// Backup that is off and has nothing on the server.
class OffBackup implements BackupRepository, RecoveryPhraseRepository {
  @override
  Future<Either<ApplicationError, bool>> isOn() async => const Right(false);

  @override
  Future<Either<ApplicationError, bool>> hasRemote() async =>
      const Right(false);

  @override
  Future<Either<ApplicationError, List<Invite>?>> sync(
    List<Invite> local,
  ) async => const Right(null);

  @override
  Future<Either<ApplicationError, List<Invite>>> turnOn(
    List<String> phrase,
    List<Invite> local,
  ) async => Right(local);

  @override
  Future<Either<ApplicationError, List<Invite>>> restore(
    List<String> phrase,
    List<Invite> local,
  ) async => Right(local);

  @override
  Future<Either<ApplicationError, Unit>> turnOff() async => const Right(unit);

  @override
  Future<Either<ApplicationError, List<String>>> generate() async =>
      Right(List.filled(12, 'abandon'));

  @override
  Future<Either<ApplicationError, List<String>>> parse(String input) async =>
      Right(input.split(' '));
}

/// Registers the BLoCs over [gate] and pumps the whole app at an iPhone 17
/// size. Haptics and the clipboard go to a platform channel a test has no
/// host for, so it is stubbed.
Future<void> pumpGatepass(
  WidgetTester tester,
  FakeGate gate, {
  MemoryArchive? archive,
  bool signedIn = false,
  Widget Function(Widget app)? wrap,
}) async {
  tester.view.physicalSize = const Size(402 * 3, 874 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, (_) async => null);
  if (signedIn && !gate.restore.isCompleted) {
    gate.restore.complete(gate.account);
  }
  await getIt.reset();
  final backup = OffBackup();
  getIt
    ..registerLazySingleton(() => SessionBloc(gate))
    ..registerFactory(() => SignInBloc(gate))
    ..registerLazySingleton(
      () => InvitesBloc(gate, archive ?? MemoryArchive()),
    )
    ..registerLazySingleton(() => NotificationsBloc(gate))
    ..registerLazySingleton(() => BackupBloc(backup, backup))
    ..registerLazySingleton(AppearanceBloc.new);
  const app = GatepassProviders();
  await tester.pumpWidget(wrap == null ? app : wrap(app));
  await tester.pump();
}
