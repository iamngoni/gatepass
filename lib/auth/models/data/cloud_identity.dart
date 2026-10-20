//
//  Gatepass
//  cloud_identity.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cloud_identity.freezed.dart';

/// Who the cloud backup is for: the Firebase uid and a fresh ID token the
/// backup Worker verifies.
@freezed
abstract class CloudIdentity with _$CloudIdentity {
  const factory CloudIdentity({
    required String uid,
    required String idToken,
  }) = _CloudIdentity;
}
