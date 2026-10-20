//
//  Gatepass
//  share_texts.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import '../../../core/utils/gp_format.dart';
import '../../models/data/invite.dart';

/// ATG's public visitor page for a code. It shows the same QR as the app.
Uri visitorLink(String code) =>
    Uri.https('new.atthegate.biz', '/visitor/shared', {'code': code});

/// For a driver or a delivery app's note field. Raw, not grouped, so nobody
/// types the spaces.
String gateCodeText(GpFormat format, Invite invite, String siteName) =>
    invite.openEnded
    ? format.l10n.shareGateCode(siteName, invite.code)
    : format.l10n.shareGateCodeUntil(
        siteName,
        invite.code,
        format.time(invite.until),
      );

String inviteMessage(GpFormat format, Invite invite, String siteName) =>
    format.l10n.shareInviteMessage(
      invite.firstName,
      siteName,
      format.validity(invite),
      visitorLink(invite.code).toString(),
      invite.code,
    );
