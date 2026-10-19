// Gatepass — account_session.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

import 'resident.dart';
import 'site.dart';

part 'account_session.freezed.dart';

/// Who is signed in and which estate they're in.
@freezed
abstract class AccountSession with _$AccountSession {
  const factory AccountSession({
    required Resident resident,
    required Site site,
  }) = _AccountSession;
}
