// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kdf_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KdfParams {

 int get memoryKib; int get iterations;
/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KdfParamsCopyWith<KdfParams> get copyWith => _$KdfParamsCopyWithImpl<KdfParams>(this as KdfParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KdfParams&&(identical(other.memoryKib, memoryKib) || other.memoryKib == memoryKib)&&(identical(other.iterations, iterations) || other.iterations == iterations));
}


@override
int get hashCode => Object.hash(runtimeType,memoryKib,iterations);

@override
String toString() {
  return 'KdfParams(memoryKib: $memoryKib, iterations: $iterations)';
}


}

/// @nodoc
abstract mixin class $KdfParamsCopyWith<$Res>  {
  factory $KdfParamsCopyWith(KdfParams value, $Res Function(KdfParams) _then) = _$KdfParamsCopyWithImpl;
@useResult
$Res call({
 int memoryKib, int iterations
});




}
/// @nodoc
class _$KdfParamsCopyWithImpl<$Res>
    implements $KdfParamsCopyWith<$Res> {
  _$KdfParamsCopyWithImpl(this._self, this._then);

  final KdfParams _self;
  final $Res Function(KdfParams) _then;

/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memoryKib = null,Object? iterations = null,}) {
  return _then(_self.copyWith(
memoryKib: null == memoryKib ? _self.memoryKib : memoryKib // ignore: cast_nullable_to_non_nullable
as int,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [KdfParams].
extension KdfParamsPatterns on KdfParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KdfParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KdfParams value)  $default,){
final _that = this;
switch (_that) {
case _KdfParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KdfParams value)?  $default,){
final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memoryKib,  int iterations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
return $default(_that.memoryKib,_that.iterations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memoryKib,  int iterations)  $default,) {final _that = this;
switch (_that) {
case _KdfParams():
return $default(_that.memoryKib,_that.iterations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memoryKib,  int iterations)?  $default,) {final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
return $default(_that.memoryKib,_that.iterations);case _:
  return null;

}
}

}

/// @nodoc


class _KdfParams implements KdfParams {
  const _KdfParams({this.memoryKib = 19456, this.iterations = 2});
  

@override@JsonKey() final  int memoryKib;
@override@JsonKey() final  int iterations;

/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KdfParamsCopyWith<_KdfParams> get copyWith => __$KdfParamsCopyWithImpl<_KdfParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KdfParams&&(identical(other.memoryKib, memoryKib) || other.memoryKib == memoryKib)&&(identical(other.iterations, iterations) || other.iterations == iterations));
}


@override
int get hashCode => Object.hash(runtimeType,memoryKib,iterations);

@override
String toString() {
  return 'KdfParams(memoryKib: $memoryKib, iterations: $iterations)';
}


}

/// @nodoc
abstract mixin class _$KdfParamsCopyWith<$Res> implements $KdfParamsCopyWith<$Res> {
  factory _$KdfParamsCopyWith(_KdfParams value, $Res Function(_KdfParams) _then) = __$KdfParamsCopyWithImpl;
@override @useResult
$Res call({
 int memoryKib, int iterations
});




}
/// @nodoc
class __$KdfParamsCopyWithImpl<$Res>
    implements _$KdfParamsCopyWith<$Res> {
  __$KdfParamsCopyWithImpl(this._self, this._then);

  final _KdfParams _self;
  final $Res Function(_KdfParams) _then;

/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memoryKib = null,Object? iterations = null,}) {
  return _then(_KdfParams(
memoryKib: null == memoryKib ? _self.memoryKib : memoryKib // ignore: cast_nullable_to_non_nullable
as int,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
