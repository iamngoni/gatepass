//
//  Gatepass
//  shared_access_request_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_access_request_dto.freezed.dart';
part 'shared_access_request_dto.g.dart';

/// `POST /api/sharedAccess/v11/getList`: the estate accounts behind a login.
@freezed
abstract class SharedAccessRequestDTO with _$SharedAccessRequestDTO {
  const factory SharedAccessRequestDTO({
    required String deviceType,
    required String deviceId,
    required String appVersion,
    required String appBuildNumber,
  }) = _SharedAccessRequestDTO;

  factory SharedAccessRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$SharedAccessRequestDTOFromJson(json);
}
