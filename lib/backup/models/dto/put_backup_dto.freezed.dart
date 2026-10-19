// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'put_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PutBackupDTO {

 int get expectedVersion; String get blob;
/// Create a copy of PutBackupDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PutBackupDTOCopyWith<PutBackupDTO> get copyWith => _$PutBackupDTOCopyWithImpl<PutBackupDTO>(this as PutBackupDTO, _$identity);

  /// Serializes this PutBackupDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PutBackupDTO&&(identical(other.expectedVersion, expectedVersion) || other.expectedVersion == expectedVersion)&&(identical(other.blob, blob) || other.blob == blob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expectedVersion,blob);

@override
String toString() {
  return 'PutBackupDTO(expectedVersion: $expectedVersion, blob: $blob)';
}


}

/// @nodoc
abstract mixin class $PutBackupDTOCopyWith<$Res>  {
  factory $PutBackupDTOCopyWith(PutBackupDTO value, $Res Function(PutBackupDTO) _then) = _$PutBackupDTOCopyWithImpl;
@useResult
$Res call({
 int expectedVersion, String blob
});




}
/// @nodoc
class _$PutBackupDTOCopyWithImpl<$Res>
    implements $PutBackupDTOCopyWith<$Res> {
  _$PutBackupDTOCopyWithImpl(this._self, this._then);

  final PutBackupDTO _self;
  final $Res Function(PutBackupDTO) _then;

/// Create a copy of PutBackupDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expectedVersion = null,Object? blob = null,}) {
  return _then(_self.copyWith(
expectedVersion: null == expectedVersion ? _self.expectedVersion : expectedVersion // ignore: cast_nullable_to_non_nullable
as int,blob: null == blob ? _self.blob : blob // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PutBackupDTO].
extension PutBackupDTOPatterns on PutBackupDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PutBackupDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PutBackupDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PutBackupDTO value)  $default,){
final _that = this;
switch (_that) {
case _PutBackupDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PutBackupDTO value)?  $default,){
final _that = this;
switch (_that) {
case _PutBackupDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int expectedVersion,  String blob)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PutBackupDTO() when $default != null:
return $default(_that.expectedVersion,_that.blob);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int expectedVersion,  String blob)  $default,) {final _that = this;
switch (_that) {
case _PutBackupDTO():
return $default(_that.expectedVersion,_that.blob);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int expectedVersion,  String blob)?  $default,) {final _that = this;
switch (_that) {
case _PutBackupDTO() when $default != null:
return $default(_that.expectedVersion,_that.blob);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PutBackupDTO implements PutBackupDTO {
  const _PutBackupDTO({required this.expectedVersion, required this.blob});
  factory _PutBackupDTO.fromJson(Map<String, dynamic> json) => _$PutBackupDTOFromJson(json);

@override final  int expectedVersion;
@override final  String blob;

/// Create a copy of PutBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PutBackupDTOCopyWith<_PutBackupDTO> get copyWith => __$PutBackupDTOCopyWithImpl<_PutBackupDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PutBackupDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PutBackupDTO&&(identical(other.expectedVersion, expectedVersion) || other.expectedVersion == expectedVersion)&&(identical(other.blob, blob) || other.blob == blob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expectedVersion,blob);

@override
String toString() {
  return 'PutBackupDTO(expectedVersion: $expectedVersion, blob: $blob)';
}


}

/// @nodoc
abstract mixin class _$PutBackupDTOCopyWith<$Res> implements $PutBackupDTOCopyWith<$Res> {
  factory _$PutBackupDTOCopyWith(_PutBackupDTO value, $Res Function(_PutBackupDTO) _then) = __$PutBackupDTOCopyWithImpl;
@override @useResult
$Res call({
 int expectedVersion, String blob
});




}
/// @nodoc
class __$PutBackupDTOCopyWithImpl<$Res>
    implements _$PutBackupDTOCopyWith<$Res> {
  __$PutBackupDTOCopyWithImpl(this._self, this._then);

  final _PutBackupDTO _self;
  final $Res Function(_PutBackupDTO) _then;

/// Create a copy of PutBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expectedVersion = null,Object? blob = null,}) {
  return _then(_PutBackupDTO(
expectedVersion: null == expectedVersion ? _self.expectedVersion : expectedVersion // ignore: cast_nullable_to_non_nullable
as int,blob: null == blob ? _self.blob : blob // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
