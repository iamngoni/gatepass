// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteBackupDTO {

 int get version;/// ISO 8601.
 DateTime get updatedAt; String get blob;
/// Create a copy of RemoteBackupDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteBackupDTOCopyWith<RemoteBackupDTO> get copyWith => _$RemoteBackupDTOCopyWithImpl<RemoteBackupDTO>(this as RemoteBackupDTO, _$identity);

  /// Serializes this RemoteBackupDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteBackupDTO&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.blob, blob) || other.blob == blob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,updatedAt,blob);

@override
String toString() {
  return 'RemoteBackupDTO(version: $version, updatedAt: $updatedAt, blob: $blob)';
}


}

/// @nodoc
abstract mixin class $RemoteBackupDTOCopyWith<$Res>  {
  factory $RemoteBackupDTOCopyWith(RemoteBackupDTO value, $Res Function(RemoteBackupDTO) _then) = _$RemoteBackupDTOCopyWithImpl;
@useResult
$Res call({
 int version, DateTime updatedAt, String blob
});




}
/// @nodoc
class _$RemoteBackupDTOCopyWithImpl<$Res>
    implements $RemoteBackupDTOCopyWith<$Res> {
  _$RemoteBackupDTOCopyWithImpl(this._self, this._then);

  final RemoteBackupDTO _self;
  final $Res Function(RemoteBackupDTO) _then;

/// Create a copy of RemoteBackupDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? updatedAt = null,Object? blob = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,blob: null == blob ? _self.blob : blob // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoteBackupDTO].
extension RemoteBackupDTOPatterns on RemoteBackupDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteBackupDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteBackupDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteBackupDTO value)  $default,){
final _that = this;
switch (_that) {
case _RemoteBackupDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteBackupDTO value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteBackupDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  DateTime updatedAt,  String blob)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteBackupDTO() when $default != null:
return $default(_that.version,_that.updatedAt,_that.blob);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  DateTime updatedAt,  String blob)  $default,) {final _that = this;
switch (_that) {
case _RemoteBackupDTO():
return $default(_that.version,_that.updatedAt,_that.blob);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  DateTime updatedAt,  String blob)?  $default,) {final _that = this;
switch (_that) {
case _RemoteBackupDTO() when $default != null:
return $default(_that.version,_that.updatedAt,_that.blob);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteBackupDTO implements RemoteBackupDTO {
  const _RemoteBackupDTO({required this.version, required this.updatedAt, required this.blob});
  factory _RemoteBackupDTO.fromJson(Map<String, dynamic> json) => _$RemoteBackupDTOFromJson(json);

@override final  int version;
/// ISO 8601.
@override final  DateTime updatedAt;
@override final  String blob;

/// Create a copy of RemoteBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteBackupDTOCopyWith<_RemoteBackupDTO> get copyWith => __$RemoteBackupDTOCopyWithImpl<_RemoteBackupDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteBackupDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteBackupDTO&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.blob, blob) || other.blob == blob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,updatedAt,blob);

@override
String toString() {
  return 'RemoteBackupDTO(version: $version, updatedAt: $updatedAt, blob: $blob)';
}


}

/// @nodoc
abstract mixin class _$RemoteBackupDTOCopyWith<$Res> implements $RemoteBackupDTOCopyWith<$Res> {
  factory _$RemoteBackupDTOCopyWith(_RemoteBackupDTO value, $Res Function(_RemoteBackupDTO) _then) = __$RemoteBackupDTOCopyWithImpl;
@override @useResult
$Res call({
 int version, DateTime updatedAt, String blob
});




}
/// @nodoc
class __$RemoteBackupDTOCopyWithImpl<$Res>
    implements _$RemoteBackupDTOCopyWith<$Res> {
  __$RemoteBackupDTOCopyWithImpl(this._self, this._then);

  final _RemoteBackupDTO _self;
  final $Res Function(_RemoteBackupDTO) _then;

/// Create a copy of RemoteBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? updatedAt = null,Object? blob = null,}) {
  return _then(_RemoteBackupDTO(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,blob: null == blob ? _self.blob : blob // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
