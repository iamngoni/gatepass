// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupKey {

 Uint8List get bytes; Uint8List get salt; KdfParams get params;
/// Create a copy of BackupKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupKeyCopyWith<BackupKey> get copyWith => _$BackupKeyCopyWithImpl<BackupKey>(this as BackupKey, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupKey&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other.salt, salt)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(salt),params);

@override
String toString() {
  return 'BackupKey(bytes: $bytes, salt: $salt, params: $params)';
}


}

/// @nodoc
abstract mixin class $BackupKeyCopyWith<$Res>  {
  factory $BackupKeyCopyWith(BackupKey value, $Res Function(BackupKey) _then) = _$BackupKeyCopyWithImpl;
@useResult
$Res call({
 Uint8List bytes, Uint8List salt, KdfParams params
});


$KdfParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$BackupKeyCopyWithImpl<$Res>
    implements $BackupKeyCopyWith<$Res> {
  _$BackupKeyCopyWithImpl(this._self, this._then);

  final BackupKey _self;
  final $Res Function(BackupKey) _then;

/// Create a copy of BackupKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bytes = null,Object? salt = null,Object? params = null,}) {
  return _then(_self.copyWith(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as Uint8List,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as KdfParams,
  ));
}
/// Create a copy of BackupKey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KdfParamsCopyWith<$Res> get params {
  
  return $KdfParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// Adds pattern-matching-related methods to [BackupKey].
extension BackupKeyPatterns on BackupKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupKey value)  $default,){
final _that = this;
switch (_that) {
case _BackupKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupKey value)?  $default,){
final _that = this;
switch (_that) {
case _BackupKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uint8List bytes,  Uint8List salt,  KdfParams params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupKey() when $default != null:
return $default(_that.bytes,_that.salt,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uint8List bytes,  Uint8List salt,  KdfParams params)  $default,) {final _that = this;
switch (_that) {
case _BackupKey():
return $default(_that.bytes,_that.salt,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uint8List bytes,  Uint8List salt,  KdfParams params)?  $default,) {final _that = this;
switch (_that) {
case _BackupKey() when $default != null:
return $default(_that.bytes,_that.salt,_that.params);case _:
  return null;

}
}

}

/// @nodoc


class _BackupKey implements BackupKey {
  const _BackupKey({required this.bytes, required this.salt, required this.params});
  

@override final  Uint8List bytes;
@override final  Uint8List salt;
@override final  KdfParams params;

/// Create a copy of BackupKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupKeyCopyWith<_BackupKey> get copyWith => __$BackupKeyCopyWithImpl<_BackupKey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupKey&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other.salt, salt)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(salt),params);

@override
String toString() {
  return 'BackupKey(bytes: $bytes, salt: $salt, params: $params)';
}


}

/// @nodoc
abstract mixin class _$BackupKeyCopyWith<$Res> implements $BackupKeyCopyWith<$Res> {
  factory _$BackupKeyCopyWith(_BackupKey value, $Res Function(_BackupKey) _then) = __$BackupKeyCopyWithImpl;
@override @useResult
$Res call({
 Uint8List bytes, Uint8List salt, KdfParams params
});


@override $KdfParamsCopyWith<$Res> get params;

}
/// @nodoc
class __$BackupKeyCopyWithImpl<$Res>
    implements _$BackupKeyCopyWith<$Res> {
  __$BackupKeyCopyWithImpl(this._self, this._then);

  final _BackupKey _self;
  final $Res Function(_BackupKey) _then;

/// Create a copy of BackupKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? salt = null,Object? params = null,}) {
  return _then(_BackupKey(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as Uint8List,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as KdfParams,
  ));
}

/// Create a copy of BackupKey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KdfParamsCopyWith<$Res> get params {
  
  return $KdfParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

// dart format on
