//
//  Gatepass
//  backup_repository_test.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/auth/models/data/account_session.dart';
import 'package:gatepass/auth/models/data/cloud_identity.dart';
import 'package:gatepass/auth/models/data/otp_channel.dart';
import 'package:gatepass/auth/models/repos/abs/auth_repository.dart';
import 'package:gatepass/backup/models/data/kdf_params.dart';
import 'package:gatepass/backup/models/data/remote_backup.dart';
import 'package:gatepass/backup/models/repos/abs/backup_store_repository.dart';
import 'package:gatepass/backup/models/repos/impl/cloud_backup_repository.dart';
import 'package:gatepass/core/models/data/application_error.dart';
import 'package:gatepass/core/services/backup_cipher_service.dart';
import 'package:gatepass/invites/models/data/invite.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:gatepass/invites/models/repos/impl/secure_invite_archive_repository.dart';

import '../helpers/route_adapter.dart';

class FakeAuth implements AuthRepository {
  String uid = 'firebase-uid';

  @override
  Future<Either<ApplicationError, CloudIdentity>> cloudIdentity() async =>
      Right(CloudIdentity(uid: uid, idToken: 'token-$uid'));

  @override
  Future<Either<ApplicationError, Unit>> requestCode(
    String phone, {
    OtpChannel channel = OtpChannel.sms,
  }) => throw UnimplementedError();

  @override
  Future<Either<ApplicationError, AccountSession?>> restoreSession() =>
      throw UnimplementedError();

  @override
  Future<Either<ApplicationError, AccountSession>> signIn({
    required String phone,
    required String code,
  }) => throw UnimplementedError();

  @override
  Future<Either<ApplicationError, Unit>> signOut() =>
      throw UnimplementedError();
}

class MemoryBackupStore implements BackupStoreRepository {
  final byToken = <String, RemoteBackup>{};

  /// Simulates another phone writing between this phone's read and write.
  int conflictsLeft = 0;

  @override
  Future<Either<ApplicationError, RemoteBackup?>> fetch(String idToken) async =>
      Right(byToken[idToken]);

  @override
  Future<Either<ApplicationError, int>> put(
    String idToken,
    int expectedVersion,
    String blob,
  ) async {
    final version = byToken[idToken]?.version ?? 0;
    if (conflictsLeft > 0 || version != expectedVersion) {
      conflictsLeft--;
      return const Left(
        ApplicationError(code: ApplicationErrorCode.backupConflict),
      );
    }
    byToken[idToken] = RemoteBackup(
      version: version + 1,
      blob: blob,
      updatedAt: DateTime.now(),
    );
    return Right(version + 1);
  }

  @override
  Future<Either<ApplicationError, Unit>> delete(String idToken) async {
    byToken.remove(idToken);
    return const Right(unit);
  }
}

void main() {
  final fixture =
      jsonDecode(
            File('test/fixtures/legacy_v0_1_1.json').readAsStringSync(),
          )
          as Map<String, dynamic>;
  final phrase = (fixture['phrase'] as String).split(' ');
  const cheap = KdfParams(memoryKib: 64, iterations: 1);

  late FakeAuth auth;
  late MemoryBackupStore store;
  late MemorySecureStorageService storage;

  CloudBackupRepository repo() => CloudBackupRepository(
    auth,
    store,
    BackupCipherService(),
    storage,
    cheap,
  );

  Invite invite(String id, {InviteStatus status = InviteStatus.active}) =>
      Invite(
        id: id,
        siteId: 's',
        visitorName: 'Visitor $id',
        from: DateTime(2026, 10, 19, 9),
        until: DateTime(2026, 10, 19, 10),
        status: status,
        code: 'C$id',
        link: '',
        createdAt: DateTime(2026, 10, 19, 8),
      );

  setUp(() {
    auth = FakeAuth();
    store = MemoryBackupStore();
    storage = MemorySecureStorageService();
  });

  test('archive reads what v0.1.1 wrote, under the same key', () async {
    final archive = SecureInviteArchiveRepository(storage);
    storage.values[SecureInviteArchiveRepository.keyFor('host-1')] =
        fixture['archive'] as String;
    final invites = (await archive.load('host-1')).getOrElse(
      () => throw StateError('left'),
    );
    expect(invites.map((i) => i.id), ['p1', 'p2']);
    expect(invites[0].status, InviteStatus.revoked);
    expect(invites[0].phone, '+27825550199');
    expect(invites[1].openEnded, isTrue);
    expect(invites[1].windowText, '19 Oct – 20 Oct');
    expect(
      invites[0].from,
      DateTime.fromMillisecondsSinceEpoch(1760860800000),
    );
    expect(
      SecureInviteArchiveRepository.keyFor('host-1'),
      matches(RegExp(r'^invites\.[0-9a-f]{32}$')),
    );

    await archive.save('host-1', invites);
    final reread = (await archive.load('host-1')).getOrElse(
      () => throw StateError('left'),
    );
    expect(reread, unorderedEquals(invites));
  });

  test('archive keeps the newest 1000', () async {
    final archive = SecureInviteArchiveRepository(storage);
    await archive.save('a', [
      for (var i = 0; i < 1005; i++)
        invite(
          '$i',
        ).copyWith(createdAt: DateTime(2026).add(Duration(hours: i))),
    ]);
    final kept = (await archive.load(
      'a',
    )).getOrElse(() => throw StateError(''));
    expect(kept, hasLength(1000));
    expect(kept.first.id, '1004');
  });

  test('a v0.1.1 backup and stored key open with the new code', () async {
    auth.uid = fixture['uid'] as String;
    store.byToken['token-${auth.uid}'] = RemoteBackup(
      version: 4,
      blob: fixture['sealed'] as String,
      updatedAt: DateTime.now(),
    );
    storage.values[CloudBackupRepository.keyNameFor(auth.uid)] =
        fixture['storedKey'] as String;
    final backup = repo();
    expect((await backup.isOn()).getOrElse(() => false), isTrue);
    final merged = (await backup.sync([invite('local')])).getOrElse(
      () => throw StateError('left'),
    );
    expect(merged!.map((i) => i.id).toSet(), {'local', 'p1', 'p2'});
    expect(store.byToken.values.single.version, 5);

    // And restoring from the phrase alone, as on a new phone.
    storage.values.clear();
    final restored = (await repo().restore(phrase, const [])).getOrElse(
      () => throw StateError('left'),
    );
    expect(restored.map((i) => i.id).toSet(), {'local', 'p1', 'p2'});
  });

  test('the wrong phrase is a decrypt error', () async {
    store.byToken['token-${auth.uid}'] = RemoteBackup(
      version: 1,
      blob: fixture['sealed'] as String,
      updatedAt: DateTime.now(),
    );
    final result = await repo().restore(List.filled(12, 'zoo'), const []);
    expect(
      result.fold((l) => l.code, (_) => null),
      ApplicationErrorCode.backupDecrypt,
    );
    expect(storage.values, isEmpty);
  });

  test('turnOn, sync with conflicts, union and turnOff', () async {
    final backup = repo();
    expect((await backup.sync(const [])).getOrElse(() => []), isNull);
    await backup.turnOn(phrase, [invite('a')]);
    expect((await backup.hasRemote()).getOrElse(() => false), isTrue);

    store.conflictsLeft = 2;
    final merged = (await backup.sync([
      invite('a', status: InviteStatus.revoked),
      invite('b'),
    ])).getOrElse(() => throw StateError('left'));
    expect(merged!.map((i) => i.id).toSet(), {'a', 'b'});
    expect(
      merged.firstWhere((i) => i.id == 'a').status,
      InviteStatus.revoked,
    );

    store.conflictsLeft = 3;
    final failed = await backup.sync([invite('c')]);
    expect(
      failed.fold((l) => l.code, (_) => null),
      ApplicationErrorCode.backupConflict,
    );

    await backup.turnOff();
    expect(store.byToken, isEmpty);
    expect((await backup.isOn()).getOrElse(() => true), isFalse);
  });
}
