// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_receipt_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupReceiptDTO {

 int get version;
/// Create a copy of BackupReceiptDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupReceiptDTOCopyWith<BackupReceiptDTO> get copyWith => _$BackupReceiptDTOCopyWithImpl<BackupReceiptDTO>(this as BackupReceiptDTO, _$identity);

  /// Serializes this BackupReceiptDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupReceiptDTO&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'BackupReceiptDTO(version: $version)';
}


}

/// @nodoc
abstract mixin class $BackupReceiptDTOCopyWith<$Res>  {
  factory $BackupReceiptDTOCopyWith(BackupReceiptDTO value, $Res Function(BackupReceiptDTO) _then) = _$BackupReceiptDTOCopyWithImpl;
@useResult
$Res call({
 int version
});




}
/// @nodoc
class _$BackupReceiptDTOCopyWithImpl<$Res>
    implements $BackupReceiptDTOCopyWith<$Res> {
  _$BackupReceiptDTOCopyWithImpl(this._self, this._then);

  final BackupReceiptDTO _self;
  final $Res Function(BackupReceiptDTO) _then;

/// Create a copy of BackupReceiptDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupReceiptDTO].
extension BackupReceiptDTOPatterns on BackupReceiptDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupReceiptDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupReceiptDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupReceiptDTO value)  $default,){
final _that = this;
switch (_that) {
case _BackupReceiptDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupReceiptDTO value)?  $default,){
final _that = this;
switch (_that) {
case _BackupReceiptDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupReceiptDTO() when $default != null:
return $default(_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version)  $default,) {final _that = this;
switch (_that) {
case _BackupReceiptDTO():
return $default(_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version)?  $default,) {final _that = this;
switch (_that) {
case _BackupReceiptDTO() when $default != null:
return $default(_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupReceiptDTO implements BackupReceiptDTO {
  const _BackupReceiptDTO({required this.version});
  factory _BackupReceiptDTO.fromJson(Map<String, dynamic> json) => _$BackupReceiptDTOFromJson(json);

@override final  int version;

/// Create a copy of BackupReceiptDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupReceiptDTOCopyWith<_BackupReceiptDTO> get copyWith => __$BackupReceiptDTOCopyWithImpl<_BackupReceiptDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupReceiptDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupReceiptDTO&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'BackupReceiptDTO(version: $version)';
}


}

/// @nodoc
abstract mixin class _$BackupReceiptDTOCopyWith<$Res> implements $BackupReceiptDTOCopyWith<$Res> {
  factory _$BackupReceiptDTOCopyWith(_BackupReceiptDTO value, $Res Function(_BackupReceiptDTO) _then) = __$BackupReceiptDTOCopyWithImpl;
@override @useResult
$Res call({
 int version
});




}
/// @nodoc
class __$BackupReceiptDTOCopyWithImpl<$Res>
    implements _$BackupReceiptDTOCopyWith<$Res> {
  __$BackupReceiptDTOCopyWithImpl(this._self, this._then);

  final _BackupReceiptDTO _self;
  final $Res Function(_BackupReceiptDTO) _then;

/// Create a copy of BackupReceiptDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,}) {
  return _then(_BackupReceiptDTO(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
