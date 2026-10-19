// Gatepass — shared_access_account_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/atg_json.dart';

part 'shared_access_account_dto.freezed.dart';
part 'shared_access_account_dto.g.dart';

/// One estate account in the shared-access list. `hostUid` is the account
/// uid visitor endpoints use, distinct from the Firebase login uid.
@freezed
abstract class SharedAccessAccountDTO with _$SharedAccessAccountDTO {
  const factory SharedAccessAccountDTO({
    @JsonKey(readValue: _readHostUid) String? hostUid,
    @JsonKey(readValue: _readEstate) String? estateName,
    @JsonKey(readValue: _readUnit) String? unit,
    @JsonKey(readValue: _readName) String? residentName,
    @JsonKey(readValue: _readEmail) String? email,
  }) = _SharedAccessAccountDTO;

  factory SharedAccessAccountDTO.fromJson(Map<String, dynamic> json) =>
      _$SharedAccessAccountDTOFromJson(json);
}

Object? _readHostUid(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['hostUid', 'accountUid']);

Object? _readEstate(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['accountName', 'name']);

Object? _readUnit(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['invitationsUserUnit', 'unit']);

Object? _readName(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['invitationsUserName'])?.trim();

Object? _readEmail(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['email']);
