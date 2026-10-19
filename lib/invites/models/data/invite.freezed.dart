// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Invite {

 String get id; String get siteId; String get visitorName;@EpochMillisConverter() DateTime get from;@EpochMillisConverter() DateTime get until; InviteStatus get status; String get code; String get link;@EpochMillisConverter() DateTime get createdAt;/// Set for delivery and ride invites; see `deliveryServices`.
 String? get serviceId; String? get phone; String? get vehicleReg;/// True when ATG gave this profile no `validFrom`/`validTill` window.
/// Such an invite is valid until it is used up or revoked; it is not a
/// same-day booking, so the UI must not invent times for it.
 bool get openEnded;/// ATG's own formatted window text, when it supplies one.
 String? get windowText;
/// Create a copy of Invite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteCopyWith<Invite> get copyWith => _$InviteCopyWithImpl<Invite>(this as Invite, _$identity);

  /// Serializes this Invite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invite&&(identical(other.id, id) || other.id == id)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&(identical(other.visitorName, visitorName) || other.visitorName == visitorName)&&(identical(other.from, from) || other.from == from)&&(identical(other.until, until) || other.until == until)&&(identical(other.status, status) || other.status == status)&&(identical(other.code, code) || other.code == code)&&(identical(other.link, link) || other.link == link)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg)&&(identical(other.openEnded, openEnded) || other.openEnded == openEnded)&&(identical(other.windowText, windowText) || other.windowText == windowText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,siteId,visitorName,from,until,status,code,link,createdAt,serviceId,phone,vehicleReg,openEnded,windowText);

@override
String toString() {
  return 'Invite(id: $id, siteId: $siteId, visitorName: $visitorName, from: $from, until: $until, status: $status, code: $code, link: $link, createdAt: $createdAt, serviceId: $serviceId, phone: $phone, vehicleReg: $vehicleReg, openEnded: $openEnded, windowText: $windowText)';
}


}

/// @nodoc
abstract mixin class $InviteCopyWith<$Res>  {
  factory $InviteCopyWith(Invite value, $Res Function(Invite) _then) = _$InviteCopyWithImpl;
@useResult
$Res call({
 String id, String siteId, String visitorName,@EpochMillisConverter() DateTime from,@EpochMillisConverter() DateTime until, InviteStatus status, String code, String link,@EpochMillisConverter() DateTime createdAt, String? serviceId, String? phone, String? vehicleReg, bool openEnded, String? windowText
});




}
/// @nodoc
class _$InviteCopyWithImpl<$Res>
    implements $InviteCopyWith<$Res> {
  _$InviteCopyWithImpl(this._self, this._then);

  final Invite _self;
  final $Res Function(Invite) _then;

/// Create a copy of Invite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? siteId = null,Object? visitorName = null,Object? from = null,Object? until = null,Object? status = null,Object? code = null,Object? link = null,Object? createdAt = null,Object? serviceId = freezed,Object? phone = freezed,Object? vehicleReg = freezed,Object? openEnded = null,Object? windowText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,siteId: null == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String,visitorName: null == visitorName ? _self.visitorName : visitorName // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,until: null == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InviteStatus,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,vehicleReg: freezed == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String?,openEnded: null == openEnded ? _self.openEnded : openEnded // ignore: cast_nullable_to_non_nullable
as bool,windowText: freezed == windowText ? _self.windowText : windowText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Invite].
extension InvitePatterns on Invite {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Invite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Invite() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Invite value)  $default,){
final _that = this;
switch (_that) {
case _Invite():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Invite value)?  $default,){
final _that = this;
switch (_that) {
case _Invite() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String siteId,  String visitorName, @EpochMillisConverter()  DateTime from, @EpochMillisConverter()  DateTime until,  InviteStatus status,  String code,  String link, @EpochMillisConverter()  DateTime createdAt,  String? serviceId,  String? phone,  String? vehicleReg,  bool openEnded,  String? windowText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invite() when $default != null:
return $default(_that.id,_that.siteId,_that.visitorName,_that.from,_that.until,_that.status,_that.code,_that.link,_that.createdAt,_that.serviceId,_that.phone,_that.vehicleReg,_that.openEnded,_that.windowText);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String siteId,  String visitorName, @EpochMillisConverter()  DateTime from, @EpochMillisConverter()  DateTime until,  InviteStatus status,  String code,  String link, @EpochMillisConverter()  DateTime createdAt,  String? serviceId,  String? phone,  String? vehicleReg,  bool openEnded,  String? windowText)  $default,) {final _that = this;
switch (_that) {
case _Invite():
return $default(_that.id,_that.siteId,_that.visitorName,_that.from,_that.until,_that.status,_that.code,_that.link,_that.createdAt,_that.serviceId,_that.phone,_that.vehicleReg,_that.openEnded,_that.windowText);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String siteId,  String visitorName, @EpochMillisConverter()  DateTime from, @EpochMillisConverter()  DateTime until,  InviteStatus status,  String code,  String link, @EpochMillisConverter()  DateTime createdAt,  String? serviceId,  String? phone,  String? vehicleReg,  bool openEnded,  String? windowText)?  $default,) {final _that = this;
switch (_that) {
case _Invite() when $default != null:
return $default(_that.id,_that.siteId,_that.visitorName,_that.from,_that.until,_that.status,_that.code,_that.link,_that.createdAt,_that.serviceId,_that.phone,_that.vehicleReg,_that.openEnded,_that.windowText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invite extends Invite {
  const _Invite({required this.id, required this.siteId, required this.visitorName, @EpochMillisConverter() required this.from, @EpochMillisConverter() required this.until, required this.status, required this.code, required this.link, @EpochMillisConverter() required this.createdAt, this.serviceId, this.phone, this.vehicleReg, this.openEnded = false, this.windowText}): super._();
  factory _Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

@override final  String id;
@override final  String siteId;
@override final  String visitorName;
@override@EpochMillisConverter() final  DateTime from;
@override@EpochMillisConverter() final  DateTime until;
@override final  InviteStatus status;
@override final  String code;
@override final  String link;
@override@EpochMillisConverter() final  DateTime createdAt;
/// Set for delivery and ride invites; see `deliveryServices`.
@override final  String? serviceId;
@override final  String? phone;
@override final  String? vehicleReg;
/// True when ATG gave this profile no `validFrom`/`validTill` window.
/// Such an invite is valid until it is used up or revoked; it is not a
/// same-day booking, so the UI must not invent times for it.
@override@JsonKey() final  bool openEnded;
/// ATG's own formatted window text, when it supplies one.
@override final  String? windowText;

/// Create a copy of Invite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteCopyWith<_Invite> get copyWith => __$InviteCopyWithImpl<_Invite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invite&&(identical(other.id, id) || other.id == id)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&(identical(other.visitorName, visitorName) || other.visitorName == visitorName)&&(identical(other.from, from) || other.from == from)&&(identical(other.until, until) || other.until == until)&&(identical(other.status, status) || other.status == status)&&(identical(other.code, code) || other.code == code)&&(identical(other.link, link) || other.link == link)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg)&&(identical(other.openEnded, openEnded) || other.openEnded == openEnded)&&(identical(other.windowText, windowText) || other.windowText == windowText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,siteId,visitorName,from,until,status,code,link,createdAt,serviceId,phone,vehicleReg,openEnded,windowText);

@override
String toString() {
  return 'Invite(id: $id, siteId: $siteId, visitorName: $visitorName, from: $from, until: $until, status: $status, code: $code, link: $link, createdAt: $createdAt, serviceId: $serviceId, phone: $phone, vehicleReg: $vehicleReg, openEnded: $openEnded, windowText: $windowText)';
}


}

/// @nodoc
abstract mixin class _$InviteCopyWith<$Res> implements $InviteCopyWith<$Res> {
  factory _$InviteCopyWith(_Invite value, $Res Function(_Invite) _then) = __$InviteCopyWithImpl;
@override @useResult
$Res call({
 String id, String siteId, String visitorName,@EpochMillisConverter() DateTime from,@EpochMillisConverter() DateTime until, InviteStatus status, String code, String link,@EpochMillisConverter() DateTime createdAt, String? serviceId, String? phone, String? vehicleReg, bool openEnded, String? windowText
});




}
/// @nodoc
class __$InviteCopyWithImpl<$Res>
    implements _$InviteCopyWith<$Res> {
  __$InviteCopyWithImpl(this._self, this._then);

  final _Invite _self;
  final $Res Function(_Invite) _then;

/// Create a copy of Invite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? siteId = null,Object? visitorName = null,Object? from = null,Object? until = null,Object? status = null,Object? code = null,Object? link = null,Object? createdAt = null,Object? serviceId = freezed,Object? phone = freezed,Object? vehicleReg = freezed,Object? openEnded = null,Object? windowText = freezed,}) {
  return _then(_Invite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,siteId: null == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String,visitorName: null == visitorName ? _self.visitorName : visitorName // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,until: null == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InviteStatus,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,vehicleReg: freezed == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String?,openEnded: null == openEnded ? _self.openEnded : openEnded // ignore: cast_nullable_to_non_nullable
as bool,windowText: freezed == windowText ? _self.windowText : windowText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
