//
//  Gatepass
//  auth_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';
import '../../data/account_session.dart';
import '../../data/cloud_identity.dart';
import '../../data/otp_channel.dart';

/// Signing in to ATG and the session behind every other request.
abstract interface class AuthRepository {
  /// Sends a sign-in code to [phone] by [channel].
  Future<Either<ApplicationError, Unit>> requestCode(
    String phone, {
    OtpChannel channel = OtpChannel.sms,
  });

  /// Verifies [code] and loads the resident's account and estate.
  Future<Either<ApplicationError, AccountSession>> signIn({
    required String phone,
    required String code,
  });

  /// Resumes the stored session. Right(null) means sign-in is required.
  Future<Either<ApplicationError, AccountSession?>> restoreSession();

  /// The Firebase uid and a fresh ID token, for the backup Worker.
  Future<Either<ApplicationError, CloudIdentity>> cloudIdentity();

  /// Forgets the stored session, so the next launch asks for a code again.
  Future<Either<ApplicationError, Unit>> signOut();
}
