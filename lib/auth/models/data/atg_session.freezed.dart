// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atg_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AtgSession {

 String get idToken; String get refreshToken;@EpochMillisConverter() DateTime get expiresAt;/// The Firebase uid, which identifies the resident to the backup.
 String? get uid; String? get phone;
/// Create a copy of AtgSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AtgSessionCopyWith<AtgSession> get copyWith => _$AtgSessionCopyWithImpl<AtgSession>(this as AtgSession, _$identity);

  /// Serializes this AtgSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AtgSession&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,refreshToken,expiresAt,uid,phone);

@override
String toString() {
  return 'AtgSession(idToken: $idToken, refreshToken: $refreshToken, expiresAt: $expiresAt, uid: $uid, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $AtgSessionCopyWith<$Res>  {
  factory $AtgSessionCopyWith(AtgSession value, $Res Function(AtgSession) _then) = _$AtgSessionCopyWithImpl;
@useResult
$Res call({
 String idToken, String refreshToken,@EpochMillisConverter() DateTime expiresAt, String? uid, String? phone
});




}
/// @nodoc
class _$AtgSessionCopyWithImpl<$Res>
    implements $AtgSessionCopyWith<$Res> {
  _$AtgSessionCopyWithImpl(this._self, this._then);

  final AtgSession _self;
  final $Res Function(AtgSession) _then;

/// Create a copy of AtgSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idToken = null,Object? refreshToken = null,Object? expiresAt = null,Object? uid = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AtgSession].
extension AtgSessionPatterns on AtgSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AtgSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AtgSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AtgSession value)  $default,){
final _that = this;
switch (_that) {
case _AtgSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AtgSession value)?  $default,){
final _that = this;
switch (_that) {
case _AtgSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idToken,  String refreshToken, @EpochMillisConverter()  DateTime expiresAt,  String? uid,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AtgSession() when $default != null:
return $default(_that.idToken,_that.refreshToken,_that.expiresAt,_that.uid,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idToken,  String refreshToken, @EpochMillisConverter()  DateTime expiresAt,  String? uid,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _AtgSession():
return $default(_that.idToken,_that.refreshToken,_that.expiresAt,_that.uid,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idToken,  String refreshToken, @EpochMillisConverter()  DateTime expiresAt,  String? uid,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _AtgSession() when $default != null:
return $default(_that.idToken,_that.refreshToken,_that.expiresAt,_that.uid,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AtgSession extends AtgSession {
  const _AtgSession({required this.idToken, required this.refreshToken, @EpochMillisConverter() required this.expiresAt, this.uid, this.phone}): super._();
  factory _AtgSession.fromJson(Map<String, dynamic> json) => _$AtgSessionFromJson(json);

@override final  String idToken;
@override final  String refreshToken;
@override@EpochMillisConverter() final  DateTime expiresAt;
/// The Firebase uid, which identifies the resident to the backup.
@override final  String? uid;
@override final  String? phone;

/// Create a copy of AtgSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AtgSessionCopyWith<_AtgSession> get copyWith => __$AtgSessionCopyWithImpl<_AtgSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AtgSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AtgSession&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,refreshToken,expiresAt,uid,phone);

@override
String toString() {
  return 'AtgSession(idToken: $idToken, refreshToken: $refreshToken, expiresAt: $expiresAt, uid: $uid, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$AtgSessionCopyWith<$Res> implements $AtgSessionCopyWith<$Res> {
  factory _$AtgSessionCopyWith(_AtgSession value, $Res Function(_AtgSession) _then) = __$AtgSessionCopyWithImpl;
@override @useResult
$Res call({
 String idToken, String refreshToken,@EpochMillisConverter() DateTime expiresAt, String? uid, String? phone
});




}
/// @nodoc
class __$AtgSessionCopyWithImpl<$Res>
    implements _$AtgSessionCopyWith<$Res> {
  __$AtgSessionCopyWithImpl(this._self, this._then);

  final _AtgSession _self;
  final $Res Function(_AtgSession) _then;

/// Create a copy of AtgSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idToken = null,Object? refreshToken = null,Object? expiresAt = null,Object? uid = freezed,Object? phone = freezed,}) {
  return _then(_AtgSession(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
