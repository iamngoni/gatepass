//
//  Gatepass
//  atg_session.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/json_converters.dart';

part 'atg_session.freezed.dart';
part 'atg_session.g.dart';

/// A signed-in session: the Firebase ID token the ATG API wants, plus the
/// refresh token to renew it. Stored as JSON in secure storage under
/// `atg.session`; the field names are that stored format.
@freezed
abstract class AtgSession with _$AtgSession {
  const factory AtgSession({
    required String idToken,
    required String refreshToken,
    @EpochMillisConverter() required DateTime expiresAt,

    /// The Firebase uid, which identifies the resident to the backup.
    String? uid,
    String? phone,
  }) = _AtgSession;

  const AtgSession._();

  factory AtgSession.fromJson(Map<String, dynamic> json) =>
      _$AtgSessionFromJson(json);

  bool isExpiredAt(DateTime now) =>
      now.isAfter(expiresAt.subtract(const Duration(seconds: 30)));
}
