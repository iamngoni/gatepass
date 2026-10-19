// Gatepass — gp_icons.dart. Created 2026-10-18.
// The app's one icon family. Screens reference [GpIcons] only: the Lucide
// font underneath is an implementation detail, and no Material icon font or
// emoji is used as a designed mark.
import 'package:lucide_icons_flutter/lucide_icons.dart';

abstract final class GpIcons {
  // Tabs.
  static const home = LucideIcons.house;
  static const visitors = LucideIcons.users;
  static const history = LucideIcons.history;
  static const account = LucideIcons.circleUser;

  // Shared actions.
  static const add = LucideIcons.plus;
  static const close = LucideIcons.x;
  static const check = LucideIcons.check;
  static const checkCircle = LucideIcons.circleCheck;
  static const copy = LucideIcons.copy;
  static const share = LucideIcons.share;
  static const revoke = LucideIcons.ban;
  static const info = LucideIcons.info;
  static const alert = LucideIcons.triangleAlert;
  static const error = LucideIcons.circleAlert;
  static const chevronLeft = LucideIcons.chevronLeft;
  static const chevronRight = LucideIcons.chevronRight;
  static const chevronDown = LucideIcons.chevronDown;
  static const options = LucideIcons.slidersHorizontal;
  static const refresh = LucideIcons.refreshCw;

  // Header.
  static const bell = LucideIcons.bell;
  static const bellOff = LucideIcons.bellOff;

  // Invites and visits.
  static const invite = LucideIcons.userPlus;
  static const person = LucideIcons.user;
  static const personMissing = LucideIcons.userX;
  static const clock = LucideIcons.clock;
  static const calendar = LucideIcons.calendar;
  static const calendarCheck = LucideIcons.calendarCheck;
  static const keypad = LucideIcons.grid3x3;
  static const link = LucideIcons.link;
  static const code = LucideIcons.hash;
  static const image = LucideIcons.image;
  static const message = LucideIcons.messageSquareText;
  static const phone = LucideIcons.phone;
  static const sms = LucideIcons.messageSquare;
  static const chat = LucideIcons.messageCircle;
  static const car = LucideIcons.car;
  static const arrivals = LucideIcons.logIn;
  static const departures = LucideIcons.logOut;
  static const gate = LucideIcons.doorOpen;
  static const notice = LucideIcons.megaphone;
  static const property = LucideIcons.building2;
  static const appearance = LucideIcons.sunMoon;
  static const cloud = LucideIcons.cloud;
  static const cloudOn = LucideIcons.cloudCheck;
  static const key = LucideIcons.keyRound;
}
