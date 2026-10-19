// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_access_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedAccessRequestDTO {

 String get deviceType; String get deviceId; String get appVersion; String get appBuildNumber;
/// Create a copy of SharedAccessRequestDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedAccessRequestDTOCopyWith<SharedAccessRequestDTO> get copyWith => _$SharedAccessRequestDTOCopyWithImpl<SharedAccessRequestDTO>(this as SharedAccessRequestDTO, _$identity);

  /// Serializes this SharedAccessRequestDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedAccessRequestDTO&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceType,deviceId,appVersion,appBuildNumber);

@override
String toString() {
  return 'SharedAccessRequestDTO(deviceType: $deviceType, deviceId: $deviceId, appVersion: $appVersion, appBuildNumber: $appBuildNumber)';
}


}

/// @nodoc
abstract mixin class $SharedAccessRequestDTOCopyWith<$Res>  {
  factory $SharedAccessRequestDTOCopyWith(SharedAccessRequestDTO value, $Res Function(SharedAccessRequestDTO) _then) = _$SharedAccessRequestDTOCopyWithImpl;
@useResult
$Res call({
 String deviceType, String deviceId, String appVersion, String appBuildNumber
});




}
/// @nodoc
class _$SharedAccessRequestDTOCopyWithImpl<$Res>
    implements $SharedAccessRequestDTOCopyWith<$Res> {
  _$SharedAccessRequestDTOCopyWithImpl(this._self, this._then);

  final SharedAccessRequestDTO _self;
  final $Res Function(SharedAccessRequestDTO) _then;

/// Create a copy of SharedAccessRequestDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceType = null,Object? deviceId = null,Object? appVersion = null,Object? appBuildNumber = null,}) {
  return _then(_self.copyWith(
deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedAccessRequestDTO].
extension SharedAccessRequestDTOPatterns on SharedAccessRequestDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedAccessRequestDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedAccessRequestDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedAccessRequestDTO value)  $default,){
final _that = this;
switch (_that) {
case _SharedAccessRequestDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedAccessRequestDTO value)?  $default,){
final _that = this;
switch (_that) {
case _SharedAccessRequestDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceType,  String deviceId,  String appVersion,  String appBuildNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedAccessRequestDTO() when $default != null:
return $default(_that.deviceType,_that.deviceId,_that.appVersion,_that.appBuildNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceType,  String deviceId,  String appVersion,  String appBuildNumber)  $default,) {final _that = this;
switch (_that) {
case _SharedAccessRequestDTO():
return $default(_that.deviceType,_that.deviceId,_that.appVersion,_that.appBuildNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceType,  String deviceId,  String appVersion,  String appBuildNumber)?  $default,) {final _that = this;
switch (_that) {
case _SharedAccessRequestDTO() when $default != null:
return $default(_that.deviceType,_that.deviceId,_that.appVersion,_that.appBuildNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedAccessRequestDTO implements SharedAccessRequestDTO {
  const _SharedAccessRequestDTO({required this.deviceType, required this.deviceId, required this.appVersion, required this.appBuildNumber});
  factory _SharedAccessRequestDTO.fromJson(Map<String, dynamic> json) => _$SharedAccessRequestDTOFromJson(json);

@override final  String deviceType;
@override final  String deviceId;
@override final  String appVersion;
@override final  String appBuildNumber;

/// Create a copy of SharedAccessRequestDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedAccessRequestDTOCopyWith<_SharedAccessRequestDTO> get copyWith => __$SharedAccessRequestDTOCopyWithImpl<_SharedAccessRequestDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedAccessRequestDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedAccessRequestDTO&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceType,deviceId,appVersion,appBuildNumber);

@override
String toString() {
  return 'SharedAccessRequestDTO(deviceType: $deviceType, deviceId: $deviceId, appVersion: $appVersion, appBuildNumber: $appBuildNumber)';
}


}

/// @nodoc
abstract mixin class _$SharedAccessRequestDTOCopyWith<$Res> implements $SharedAccessRequestDTOCopyWith<$Res> {
  factory _$SharedAccessRequestDTOCopyWith(_SharedAccessRequestDTO value, $Res Function(_SharedAccessRequestDTO) _then) = __$SharedAccessRequestDTOCopyWithImpl;
@override @useResult
$Res call({
 String deviceType, String deviceId, String appVersion, String appBuildNumber
});




}
/// @nodoc
class __$SharedAccessRequestDTOCopyWithImpl<$Res>
    implements _$SharedAccessRequestDTOCopyWith<$Res> {
  __$SharedAccessRequestDTOCopyWithImpl(this._self, this._then);

  final _SharedAccessRequestDTO _self;
  final $Res Function(_SharedAccessRequestDTO) _then;

/// Create a copy of SharedAccessRequestDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceType = null,Object? deviceId = null,Object? appVersion = null,Object? appBuildNumber = null,}) {
  return _then(_SharedAccessRequestDTO(
deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
