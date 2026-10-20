//
//  Gatepass
//  user_settings_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/atg_json.dart';

part 'user_settings_dto.freezed.dart';
part 'user_settings_dto.g.dart';

/// `GET /api/user/v2/settings?uid=<hostUid>`: estate branding, the
/// resident's name and unit, and how far ahead invites may be booked.
@freezed
abstract class UserSettingsDTO with _$UserSettingsDTO {
  const factory UserSettingsDTO({
    @JsonKey(readValue: _readBrand) String? estateName,
    @JsonKey(readValue: _readUnit) String? unit,
    @JsonKey(readValue: _readFirstName) String? firstName,
    @JsonKey(readValue: _readLastName) String? lastName,
    @JsonKey(readValue: _readEmail) String? email,
    @JsonKey(readValue: _readHorizon) int? inviteHorizonDays,
  }) = _UserSettingsDTO;

  const UserSettingsDTO._();

  factory UserSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsDTOFromJson(json);

  /// First and last name joined, or null when neither is set.
  String? get fullName {
    final name = [
      firstName?.trim() ?? '',
      lastName?.trim() ?? '',
    ].where((part) => part.isNotEmpty).join(' ');
    return name.isEmpty ? null : name;
  }
}

Map<String, dynamic> _app(Map<dynamic, dynamic> json) =>
    objectOrEmpty(json['appSettings']);

Map<String, dynamic> _access(Map<dynamic, dynamic> json) =>
    objectOrEmpty(json['accessPermissions']);

Object? _readBrand(Map<dynamic, dynamic> json, String _) =>
    firstString(_app(json), const ['brandName', 'name']);

Object? _readUnit(Map<dynamic, dynamic> json, String _) =>
    firstString(_access(json), const ['invitationsUserUnit', 'unit']);

Object? _readFirstName(Map<dynamic, dynamic> json, String _) =>
    firstString(_access(json), const ['invitationsUserName', 'firstName']);

Object? _readLastName(Map<dynamic, dynamic> json, String _) =>
    firstString(_access(json), const ['invitationsUserSurname', 'lastName']);

Object? _readEmail(Map<dynamic, dynamic> json, String _) =>
    firstString(_access(json), const ['email']);

Object? _readHorizon(Map<dynamic, dynamic> json, String _) {
  final horizon = objectOrEmpty(
    json['userSettings'],
  )['invitationMaxDaysFromToday'];
  return horizon is num ? horizon.toInt().clamp(1, 365) : null;
}
