//
//  Gatepass
//  application_error.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_error.freezed.dart';

/// Why a repository operation failed, as something the UI can explain.
///
/// [message] carries only text meant for the resident, such as ATG's own
/// `{"error": "..."}` reply. Technical detail is logged, never shown.
@freezed
abstract class ApplicationError with _$ApplicationError implements Exception {
  const factory ApplicationError({
    required ApplicationErrorCode code,
    String? message,
  }) = _ApplicationError;
}

enum ApplicationErrorCode {
  /// No connection, or the server couldn't be reached.
  connection,

  /// The server took too long to answer.
  timeout,

  /// The server failed or answered with something unexpected.
  server,

  /// ATG answered with its own explanation, in [ApplicationError.message].
  atg,

  /// The stored sign-in is missing or no longer accepted.
  notSignedIn,

  /// The sign-in has no estate account behind it.
  noEstateAccount,

  /// Another phone backed up first; merge and try again.
  backupConflict,

  /// The recovery phrase doesn't open this backup.
  backupDecrypt,

  /// The backup service couldn't be reached or refused the request.
  backupUnavailable,

  /// Not the 12 words a recovery phrase needs.
  phraseInvalid,

  /// The phone's secure storage couldn't be read or written.
  storage,

  /// Anything else; the cause is in the logs.
  unknown,
}
