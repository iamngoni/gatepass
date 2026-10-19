// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_start_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginStartDTO {

 String get loginString;/// `sms` or `whatsapp`.
 String get channel; String get deviceId; String get appVersion; String get appBuildNumber; String get platform;
/// Create a copy of LoginStartDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStartDTOCopyWith<LoginStartDTO> get copyWith => _$LoginStartDTOCopyWithImpl<LoginStartDTO>(this as LoginStartDTO, _$identity);

  /// Serializes this LoginStartDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStartDTO&&(identical(other.loginString, loginString) || other.loginString == loginString)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loginString,channel,deviceId,appVersion,appBuildNumber,platform);

@override
String toString() {
  return 'LoginStartDTO(loginString: $loginString, channel: $channel, deviceId: $deviceId, appVersion: $appVersion, appBuildNumber: $appBuildNumber, platform: $platform)';
}


}

/// @nodoc
abstract mixin class $LoginStartDTOCopyWith<$Res>  {
  factory $LoginStartDTOCopyWith(LoginStartDTO value, $Res Function(LoginStartDTO) _then) = _$LoginStartDTOCopyWithImpl;
@useResult
$Res call({
 String loginString, String channel, String deviceId, String appVersion, String appBuildNumber, String platform
});




}
/// @nodoc
class _$LoginStartDTOCopyWithImpl<$Res>
    implements $LoginStartDTOCopyWith<$Res> {
  _$LoginStartDTOCopyWithImpl(this._self, this._then);

  final LoginStartDTO _self;
  final $Res Function(LoginStartDTO) _then;

/// Create a copy of LoginStartDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginString = null,Object? channel = null,Object? deviceId = null,Object? appVersion = null,Object? appBuildNumber = null,Object? platform = null,}) {
  return _then(_self.copyWith(
loginString: null == loginString ? _self.loginString : loginString // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginStartDTO].
extension LoginStartDTOPatterns on LoginStartDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginStartDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginStartDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginStartDTO value)  $default,){
final _that = this;
switch (_that) {
case _LoginStartDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginStartDTO value)?  $default,){
final _that = this;
switch (_that) {
case _LoginStartDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String loginString,  String channel,  String deviceId,  String appVersion,  String appBuildNumber,  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginStartDTO() when $default != null:
return $default(_that.loginString,_that.channel,_that.deviceId,_that.appVersion,_that.appBuildNumber,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String loginString,  String channel,  String deviceId,  String appVersion,  String appBuildNumber,  String platform)  $default,) {final _that = this;
switch (_that) {
case _LoginStartDTO():
return $default(_that.loginString,_that.channel,_that.deviceId,_that.appVersion,_that.appBuildNumber,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String loginString,  String channel,  String deviceId,  String appVersion,  String appBuildNumber,  String platform)?  $default,) {final _that = this;
switch (_that) {
case _LoginStartDTO() when $default != null:
return $default(_that.loginString,_that.channel,_that.deviceId,_that.appVersion,_that.appBuildNumber,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginStartDTO implements LoginStartDTO {
  const _LoginStartDTO({required this.loginString, required this.channel, required this.deviceId, required this.appVersion, required this.appBuildNumber, required this.platform});
  factory _LoginStartDTO.fromJson(Map<String, dynamic> json) => _$LoginStartDTOFromJson(json);

@override final  String loginString;
/// `sms` or `whatsapp`.
@override final  String channel;
@override final  String deviceId;
@override final  String appVersion;
@override final  String appBuildNumber;
@override final  String platform;

/// Create a copy of LoginStartDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStartDTOCopyWith<_LoginStartDTO> get copyWith => __$LoginStartDTOCopyWithImpl<_LoginStartDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginStartDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginStartDTO&&(identical(other.loginString, loginString) || other.loginString == loginString)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loginString,channel,deviceId,appVersion,appBuildNumber,platform);

@override
String toString() {
  return 'LoginStartDTO(loginString: $loginString, channel: $channel, deviceId: $deviceId, appVersion: $appVersion, appBuildNumber: $appBuildNumber, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$LoginStartDTOCopyWith<$Res> implements $LoginStartDTOCopyWith<$Res> {
  factory _$LoginStartDTOCopyWith(_LoginStartDTO value, $Res Function(_LoginStartDTO) _then) = __$LoginStartDTOCopyWithImpl;
@override @useResult
$Res call({
 String loginString, String channel, String deviceId, String appVersion, String appBuildNumber, String platform
});




}
/// @nodoc
class __$LoginStartDTOCopyWithImpl<$Res>
    implements _$LoginStartDTOCopyWith<$Res> {
  __$LoginStartDTOCopyWithImpl(this._self, this._then);

  final _LoginStartDTO _self;
  final $Res Function(_LoginStartDTO) _then;

/// Create a copy of LoginStartDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginString = null,Object? channel = null,Object? deviceId = null,Object? appVersion = null,Object? appBuildNumber = null,Object? platform = null,}) {
  return _then(_LoginStartDTO(
loginString: null == loginString ? _self.loginString : loginString // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
