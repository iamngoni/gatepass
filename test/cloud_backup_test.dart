import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/backup/backup_crypto.dart';
import 'package:gatepass/data/backup/cloud_backup.dart';
import 'package:gatepass/data/backup/recovery_phrase.dart';
import 'package:gatepass/data/models.dart';

// Cheap Argon2 for tests; the app uses the OWASP baseline.
const _fast = KdfParams(memoryKib: 64, iterations: 1);

Invite _invite(String id, {InviteStatus status = InviteStatus.active}) {
  final t = DateTime(2026, 10, 19, 9);
  return Invite(
    id: id,
    siteId: 's',
    visitorName: 'Chipo Ndlovu',
    from: t,
    until: t.add(const Duration(hours: 4)),
    status: status,
    code: 'CODE$id',
    link: '',
    createdAt: t,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a new phrase is 12 known words and parses back', () async {
    final phrase = await newRecoveryPhrase();
    expect(phrase, hasLength(12));
    expect(
      await parseRecoveryPhrase(' ${phrase.join('  ').toUpperCase()} '),
      phrase,
    );
    expect(await parseRecoveryPhrase('not twelve words'), isNull);
  });

  test('sealed backups open with the right key and account only', () async {
    final phrase = await newRecoveryPhrase();
    final key = await deriveBackupKey(phrase, params: _fast);
    final sealed = await sealBackup(key, 'uid-a', 'secret');
    expect(sealed, isNot(contains('secret')));
    expect(await openBackup(key, 'uid-a', sealed), 'secret');

    expect(
      () => openBackup(key, 'uid-b', sealed),
      throwsA(isA<BackupDecryptException>()),
    );
    final (salt, params) = backupKdf(sealed);
    final wrong = await deriveBackupKey(
      await newRecoveryPhrase(),
      salt: salt,
      params: params,
    );
    expect(
      () => openBackup(wrong, 'uid-a', sealed),
      throwsA(isA<BackupDecryptException>()),
    );
  });

  test('a new phone restores with the phrase, and phones merge', () async {
    final store = MemoryBackupStore();
    CloudBackup phone() => CloudBackup(
      identity: () async => (uid: 'uid-a', idToken: 'token-a'),
      store: store,
      kdf: _fast,
    );

    FlutterSecureStorage.setMockInitialValues({});
    final first = phone();
    final phrase = await newRecoveryPhrase();
    await first.turnOn(phrase, [_invite('1')]);
    expect(await first.isOn(), isTrue);

    // A fresh install: no key in its Keychain yet.
    FlutterSecureStorage.setMockInitialValues({});
    final second = phone();
    expect(await second.isOn(), isFalse);
    expect(await second.hasRemote(), isTrue);
    await expectLater(
      second.restore(await newRecoveryPhrase(), const []),
      throwsA(isA<BackupDecryptException>()),
    );
    final restored = await second.restore(phrase, [_invite('2')]);
    expect(restored.map((i) => i.id).toSet(), {'1', '2'});

    // The first phone revokes one; the second learns it on its next sync.
    final merged = await second.sync([
      _invite('1', status: InviteStatus.revoked),
    ]);
    expect(merged!.firstWhere((i) => i.id == '1').status, InviteStatus.revoked);
    expect(merged.map((i) => i.id).toSet(), {'1', '2'});

    await second.turnOff();
    expect(await second.hasRemote(), isFalse);
  });
}
