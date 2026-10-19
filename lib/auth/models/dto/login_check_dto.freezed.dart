// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_check_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginCheckDTO {

 String get contact; String get code; String get deviceId; String get appVersion; String get appBuildNumber; String get platform;
/// Create a copy of LoginCheckDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginCheckDTOCopyWith<LoginCheckDTO> get copyWith => _$LoginCheckDTOCopyWithImpl<LoginCheckDTO>(this as LoginCheckDTO, _$identity);

  /// Serializes this LoginCheckDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginCheckDTO&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.code, code) || other.code == code)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contact,code,deviceId,appVersion,appBuildNumber,platform);

@override
String toString() {
  return 'LoginCheckDTO(contact: $contact, code: $code, deviceId: $deviceId, appVersion: $appVersion, appBuildNumber: $appBuildNumber, platform: $platform)';
}


}

/// @nodoc
abstract mixin class $LoginCheckDTOCopyWith<$Res>  {
  factory $LoginCheckDTOCopyWith(LoginCheckDTO value, $Res Function(LoginCheckDTO) _then) = _$LoginCheckDTOCopyWithImpl;
@useResult
$Res call({
 String contact, String code, String deviceId, String appVersion, String appBuildNumber, String platform
});




}
/// @nodoc
class _$LoginCheckDTOCopyWithImpl<$Res>
    implements $LoginCheckDTOCopyWith<$Res> {
  _$LoginCheckDTOCopyWithImpl(this._self, this._then);

  final LoginCheckDTO _self;
  final $Res Function(LoginCheckDTO) _then;

/// Create a copy of LoginCheckDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contact = null,Object? code = null,Object? deviceId = null,Object? appVersion = null,Object? appBuildNumber = null,Object? platform = null,}) {
  return _then(_self.copyWith(
contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginCheckDTO].
extension LoginCheckDTOPatterns on LoginCheckDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginCheckDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginCheckDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginCheckDTO value)  $default,){
final _that = this;
switch (_that) {
case _LoginCheckDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginCheckDTO value)?  $default,){
final _that = this;
switch (_that) {
case _LoginCheckDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String contact,  String code,  String deviceId,  String appVersion,  String appBuildNumber,  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginCheckDTO() when $default != null:
return $default(_that.contact,_that.code,_that.deviceId,_that.appVersion,_that.appBuildNumber,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String contact,  String code,  String deviceId,  String appVersion,  String appBuildNumber,  String platform)  $default,) {final _that = this;
switch (_that) {
case _LoginCheckDTO():
return $default(_that.contact,_that.code,_that.deviceId,_that.appVersion,_that.appBuildNumber,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String contact,  String code,  String deviceId,  String appVersion,  String appBuildNumber,  String platform)?  $default,) {final _that = this;
switch (_that) {
case _LoginCheckDTO() when $default != null:
return $default(_that.contact,_that.code,_that.deviceId,_that.appVersion,_that.appBuildNumber,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginCheckDTO implements LoginCheckDTO {
  const _LoginCheckDTO({required this.contact, required this.code, required this.deviceId, required this.appVersion, required this.appBuildNumber, required this.platform});
  factory _LoginCheckDTO.fromJson(Map<String, dynamic> json) => _$LoginCheckDTOFromJson(json);

@override final  String contact;
@override final  String code;
@override final  String deviceId;
@override final  String appVersion;
@override final  String appBuildNumber;
@override final  String platform;

/// Create a copy of LoginCheckDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginCheckDTOCopyWith<_LoginCheckDTO> get copyWith => __$LoginCheckDTOCopyWithImpl<_LoginCheckDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginCheckDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginCheckDTO&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.code, code) || other.code == code)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contact,code,deviceId,appVersion,appBuildNumber,platform);

@override
String toString() {
  return 'LoginCheckDTO(contact: $contact, code: $code, deviceId: $deviceId, appVersion: $appVersion, appBuildNumber: $appBuildNumber, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$LoginCheckDTOCopyWith<$Res> implements $LoginCheckDTOCopyWith<$Res> {
  factory _$LoginCheckDTOCopyWith(_LoginCheckDTO value, $Res Function(_LoginCheckDTO) _then) = __$LoginCheckDTOCopyWithImpl;
@override @useResult
$Res call({
 String contact, String code, String deviceId, String appVersion, String appBuildNumber, String platform
});




}
/// @nodoc
class __$LoginCheckDTOCopyWithImpl<$Res>
    implements _$LoginCheckDTOCopyWith<$Res> {
  __$LoginCheckDTOCopyWithImpl(this._self, this._then);

  final _LoginCheckDTO _self;
  final $Res Function(_LoginCheckDTO) _then;

/// Create a copy of LoginCheckDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contact = null,Object? code = null,Object? deviceId = null,Object? appVersion = null,Object? appBuildNumber = null,Object? platform = null,}) {
  return _then(_LoginCheckDTO(
contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
