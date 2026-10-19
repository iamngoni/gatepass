// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InviteDraft {

 String get visitorName; DateTime get from; DateTime get until; String? get serviceId; String? get phone; String? get vehicleReg;
/// Create a copy of InviteDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteDraftCopyWith<InviteDraft> get copyWith => _$InviteDraftCopyWithImpl<InviteDraft>(this as InviteDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteDraft&&(identical(other.visitorName, visitorName) || other.visitorName == visitorName)&&(identical(other.from, from) || other.from == from)&&(identical(other.until, until) || other.until == until)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg));
}


@override
int get hashCode => Object.hash(runtimeType,visitorName,from,until,serviceId,phone,vehicleReg);

@override
String toString() {
  return 'InviteDraft(visitorName: $visitorName, from: $from, until: $until, serviceId: $serviceId, phone: $phone, vehicleReg: $vehicleReg)';
}


}

/// @nodoc
abstract mixin class $InviteDraftCopyWith<$Res>  {
  factory $InviteDraftCopyWith(InviteDraft value, $Res Function(InviteDraft) _then) = _$InviteDraftCopyWithImpl;
@useResult
$Res call({
 String visitorName, DateTime from, DateTime until, String? serviceId, String? phone, String? vehicleReg
});




}
/// @nodoc
class _$InviteDraftCopyWithImpl<$Res>
    implements $InviteDraftCopyWith<$Res> {
  _$InviteDraftCopyWithImpl(this._self, this._then);

  final InviteDraft _self;
  final $Res Function(InviteDraft) _then;

/// Create a copy of InviteDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visitorName = null,Object? from = null,Object? until = null,Object? serviceId = freezed,Object? phone = freezed,Object? vehicleReg = freezed,}) {
  return _then(_self.copyWith(
visitorName: null == visitorName ? _self.visitorName : visitorName // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,until: null == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,vehicleReg: freezed == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteDraft].
extension InviteDraftPatterns on InviteDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteDraft value)  $default,){
final _that = this;
switch (_that) {
case _InviteDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteDraft value)?  $default,){
final _that = this;
switch (_that) {
case _InviteDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String visitorName,  DateTime from,  DateTime until,  String? serviceId,  String? phone,  String? vehicleReg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteDraft() when $default != null:
return $default(_that.visitorName,_that.from,_that.until,_that.serviceId,_that.phone,_that.vehicleReg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String visitorName,  DateTime from,  DateTime until,  String? serviceId,  String? phone,  String? vehicleReg)  $default,) {final _that = this;
switch (_that) {
case _InviteDraft():
return $default(_that.visitorName,_that.from,_that.until,_that.serviceId,_that.phone,_that.vehicleReg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String visitorName,  DateTime from,  DateTime until,  String? serviceId,  String? phone,  String? vehicleReg)?  $default,) {final _that = this;
switch (_that) {
case _InviteDraft() when $default != null:
return $default(_that.visitorName,_that.from,_that.until,_that.serviceId,_that.phone,_that.vehicleReg);case _:
  return null;

}
}

}

/// @nodoc


class _InviteDraft implements InviteDraft {
  const _InviteDraft({required this.visitorName, required this.from, required this.until, this.serviceId, this.phone, this.vehicleReg});
  

@override final  String visitorName;
@override final  DateTime from;
@override final  DateTime until;
@override final  String? serviceId;
@override final  String? phone;
@override final  String? vehicleReg;

/// Create a copy of InviteDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteDraftCopyWith<_InviteDraft> get copyWith => __$InviteDraftCopyWithImpl<_InviteDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteDraft&&(identical(other.visitorName, visitorName) || other.visitorName == visitorName)&&(identical(other.from, from) || other.from == from)&&(identical(other.until, until) || other.until == until)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg));
}


@override
int get hashCode => Object.hash(runtimeType,visitorName,from,until,serviceId,phone,vehicleReg);

@override
String toString() {
  return 'InviteDraft(visitorName: $visitorName, from: $from, until: $until, serviceId: $serviceId, phone: $phone, vehicleReg: $vehicleReg)';
}


}

/// @nodoc
abstract mixin class _$InviteDraftCopyWith<$Res> implements $InviteDraftCopyWith<$Res> {
  factory _$InviteDraftCopyWith(_InviteDraft value, $Res Function(_InviteDraft) _then) = __$InviteDraftCopyWithImpl;
@override @useResult
$Res call({
 String visitorName, DateTime from, DateTime until, String? serviceId, String? phone, String? vehicleReg
});




}
/// @nodoc
class __$InviteDraftCopyWithImpl<$Res>
    implements _$InviteDraftCopyWith<$Res> {
  __$InviteDraftCopyWithImpl(this._self, this._then);

  final _InviteDraft _self;
  final $Res Function(_InviteDraft) _then;

/// Create a copy of InviteDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visitorName = null,Object? from = null,Object? until = null,Object? serviceId = freezed,Object? phone = freezed,Object? vehicleReg = freezed,}) {
  return _then(_InviteDraft(
visitorName: null == visitorName ? _self.visitorName : visitorName // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,until: null == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,vehicleReg: freezed == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
