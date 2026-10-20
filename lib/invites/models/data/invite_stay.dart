//
//  Gatepass
//  invite_stay.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

/// How long a new invite lasts. [duration] is null for the rest of the day.
enum InviteStay {
  allDay(null),
  h1(Duration(hours: 1)),
  h2(Duration(hours: 2)),
  h4(Duration(hours: 4)),
  h8(Duration(hours: 8));

  const InviteStay(this.duration);

  final Duration? duration;
}
