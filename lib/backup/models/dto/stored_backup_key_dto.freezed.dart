// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_backup_key_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoredBackupKeyDTO {

/// Base64.
 String get key;/// Base64.
 String get salt; int get m; int get t;
/// Create a copy of StoredBackupKeyDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoredBackupKeyDTOCopyWith<StoredBackupKeyDTO> get copyWith => _$StoredBackupKeyDTOCopyWithImpl<StoredBackupKeyDTO>(this as StoredBackupKeyDTO, _$identity);

  /// Serializes this StoredBackupKeyDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoredBackupKeyDTO&&(identical(other.key, key) || other.key == key)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.m, m) || other.m == m)&&(identical(other.t, t) || other.t == t));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,salt,m,t);

@override
String toString() {
  return 'StoredBackupKeyDTO(key: $key, salt: $salt, m: $m, t: $t)';
}


}

/// @nodoc
abstract mixin class $StoredBackupKeyDTOCopyWith<$Res>  {
  factory $StoredBackupKeyDTOCopyWith(StoredBackupKeyDTO value, $Res Function(StoredBackupKeyDTO) _then) = _$StoredBackupKeyDTOCopyWithImpl;
@useResult
$Res call({
 String key, String salt, int m, int t
});




}
/// @nodoc
class _$StoredBackupKeyDTOCopyWithImpl<$Res>
    implements $StoredBackupKeyDTOCopyWith<$Res> {
  _$StoredBackupKeyDTOCopyWithImpl(this._self, this._then);

  final StoredBackupKeyDTO _self;
  final $Res Function(StoredBackupKeyDTO) _then;

/// Create a copy of StoredBackupKeyDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? salt = null,Object? m = null,Object? t = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as int,t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StoredBackupKeyDTO].
extension StoredBackupKeyDTOPatterns on StoredBackupKeyDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoredBackupKeyDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoredBackupKeyDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoredBackupKeyDTO value)  $default,){
final _that = this;
switch (_that) {
case _StoredBackupKeyDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoredBackupKeyDTO value)?  $default,){
final _that = this;
switch (_that) {
case _StoredBackupKeyDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String salt,  int m,  int t)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoredBackupKeyDTO() when $default != null:
return $default(_that.key,_that.salt,_that.m,_that.t);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String salt,  int m,  int t)  $default,) {final _that = this;
switch (_that) {
case _StoredBackupKeyDTO():
return $default(_that.key,_that.salt,_that.m,_that.t);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String salt,  int m,  int t)?  $default,) {final _that = this;
switch (_that) {
case _StoredBackupKeyDTO() when $default != null:
return $default(_that.key,_that.salt,_that.m,_that.t);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoredBackupKeyDTO implements StoredBackupKeyDTO {
  const _StoredBackupKeyDTO({required this.key, required this.salt, required this.m, required this.t});
  factory _StoredBackupKeyDTO.fromJson(Map<String, dynamic> json) => _$StoredBackupKeyDTOFromJson(json);

/// Base64.
@override final  String key;
/// Base64.
@override final  String salt;
@override final  int m;
@override final  int t;

/// Create a copy of StoredBackupKeyDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoredBackupKeyDTOCopyWith<_StoredBackupKeyDTO> get copyWith => __$StoredBackupKeyDTOCopyWithImpl<_StoredBackupKeyDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoredBackupKeyDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoredBackupKeyDTO&&(identical(other.key, key) || other.key == key)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.m, m) || other.m == m)&&(identical(other.t, t) || other.t == t));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,salt,m,t);

@override
String toString() {
  return 'StoredBackupKeyDTO(key: $key, salt: $salt, m: $m, t: $t)';
}


}

/// @nodoc
abstract mixin class _$StoredBackupKeyDTOCopyWith<$Res> implements $StoredBackupKeyDTOCopyWith<$Res> {
  factory _$StoredBackupKeyDTOCopyWith(_StoredBackupKeyDTO value, $Res Function(_StoredBackupKeyDTO) _then) = __$StoredBackupKeyDTOCopyWithImpl;
@override @useResult
$Res call({
 String key, String salt, int m, int t
});




}
/// @nodoc
class __$StoredBackupKeyDTOCopyWithImpl<$Res>
    implements _$StoredBackupKeyDTOCopyWith<$Res> {
  __$StoredBackupKeyDTOCopyWithImpl(this._self, this._then);

  final _StoredBackupKeyDTO _self;
  final $Res Function(_StoredBackupKeyDTO) _then;

/// Create a copy of StoredBackupKeyDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? salt = null,Object? m = null,Object? t = null,}) {
  return _then(_StoredBackupKeyDTO(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as int,t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
