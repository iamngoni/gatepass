// Gatepass — dio_invite_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/configs/atg_config.dart';
import '../../../../core/models/data/application_error.dart';
import '../../../../core/services/atg_account_service.dart';
import '../../../../core/utils/atg_json.dart';
import '../../../../core/utils/dio_error_mapper.dart';
import '../../../../core/utils/interceptors/atg_auth_interceptor.dart';
import '../../../../core/utils/phone_numbers.dart';
import '../../data/invite.dart';
import '../../data/invite_draft.dart';
import '../../dto/atg_visitor_dto.dart';
import '../../dto/create_visitor_dto.dart';
import '../../dto/visitor_category_dto.dart';
import '../abs/invite_repository.dart';

/// Invitations through ATG's visitor-profile endpoints, as the signed-in
/// resident's estate account.
@LazySingleton(as: InviteRepository)
class DioInviteRepository implements InviteRepository {
  DioInviteRepository(@Named('atg') this.dio, this.accounts);

  final Dio dio;
  final AtgAccountService accounts;

  /// The estate's "Invitation" category id, per host uid.
  final _categoryIds = <String, int>{};

  @override
  Future<Either<ApplicationError, List<Invite>>> fetchInvites(
    String siteId,
  ) async {
    try {
      final response = await dio.get<Object?>(
        AtgConfig.invitesListPath,
        queryParameters: {
          'uid': ?accounts.hostUid,
          'limit': '$invitePageLimit',
        },
        options: AtgAuthInterceptor.authed('invites'),
      );
      final now = DateTime.now();
      return Right([
        for (final json in objectsOf(response.data))
          AtgVisitorDTO.fromJson(json).toInvite(siteId: siteId, now: now),
      ]);
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'invites'));
    }
  }

  @override
  Future<Either<ApplicationError, Invite>> createInvite(
    String siteId,
    InviteDraft draft,
  ) async {
    final (first, last) = splitFullName(draft.visitorName);
    try {
      final body = CreateVisitorDTO(
        uid: accounts.hostUid,
        name: first,
        surname: last.isEmpty ? null : last,
        phoneNumber: draft.phone,
        carLic: draft.vehicleReg,
        categoryId: await _invitationCategory(),
        // ATG stores timestamps as epoch milliseconds.
        validFrom: draft.from.toUtc().millisecondsSinceEpoch,
        validTill: draft.until.toUtc().millisecondsSinceEpoch,
      ).toJson();
      final guard = _guardWrite('create invite', body);
      if (guard != null) return Left(guard);

      final response = await dio.post<Object?>(
        AtgConfig.createVisitorPath,
        data: body,
        options: AtgAuthInterceptor.authed('create'),
      );
      final now = DateTime.now();
      // Creating the profile already returns its code and share link, so
      // no second "share" request is needed. Sending the link stays an
      // explicit resident action.
      return Right(
        AtgVisitorDTO.fromJson(objectOrEmpty(response.data)).toInvite(
          siteId: siteId,
          now: now,
          draft: draft,
          fallbackId: 'atg-${now.millisecondsSinceEpoch}',
        ),
      );
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'create'));
    }
  }

  @override
  Future<Either<ApplicationError, Unit>> revokeInvite(String inviteId) async {
    // Verified live: this endpoint ignores a JSON body and answers
    // `500 id can't be null`. It wants the id as a form parameter.
    final body = {AtgConfig.fProfileId: inviteId};
    final guard = _guardWrite('revoke invite', body);
    if (guard != null) return Left(guard);
    try {
      await dio.post<Object?>(
        AtgConfig.deleteVisitorPath,
        data: body,
        options: AtgAuthInterceptor.authed(
          'revoke',
          contentType: 'application/x-www-form-urlencoded; charset=utf-8',
        ),
      );
      return const Right(unit);
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'revoke'));
    }
  }

  /// ATG rejects a create without the estate's "Invitation" category, and
  /// the id is per-estate, so it is read rather than hardcoded. A failed
  /// read sends the create without one, as earlier builds did.
  Future<int?> _invitationCategory() async {
    final uid = accounts.hostUid ?? '';
    final cached = _categoryIds[uid];
    if (cached != null) return cached;
    try {
      final response = await dio.get<Object?>(
        AtgConfig.categoriesPath,
        queryParameters: {'uid': ?accounts.hostUid},
        options: AtgAuthInterceptor.authed('categories'),
      );
      for (final json in objectsOf(response.data)) {
        final category = VisitorCategoryDTO.fromJson(json);
        final id = category.id;
        if (category.isInvitation && id != null) {
          return _categoryIds[uid] = id;
        }
      }
    } on Object catch (e) {
      debugPrint('[ATG] visitor categories unavailable: $e');
    }
    return null;
  }

  /// With [AtgConfig.dryRunWrites] on, logs the composed request and
  /// refuses it, so a wrong body can't reach the estate.
  static ApplicationError? _guardWrite(String what, Map<String, Object?> body) {
    if (!AtgConfig.dryRunWrites) return null;
    debugPrint('[ATG] DRY RUN — $what was NOT sent\n$body');
    return const ApplicationError(
      code: ApplicationErrorCode.atg,
      message: 'Dry run: nothing was sent to ATG.',
    );
  }
}
