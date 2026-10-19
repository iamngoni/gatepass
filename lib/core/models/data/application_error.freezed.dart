// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationError {

 ApplicationErrorCode get code; String? get message;
/// Create a copy of ApplicationError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationErrorCopyWith<ApplicationError> get copyWith => _$ApplicationErrorCopyWithImpl<ApplicationError>(this as ApplicationError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ApplicationError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ApplicationErrorCopyWith<$Res>  {
  factory $ApplicationErrorCopyWith(ApplicationError value, $Res Function(ApplicationError) _then) = _$ApplicationErrorCopyWithImpl;
@useResult
$Res call({
 ApplicationErrorCode code, String? message
});




}
/// @nodoc
class _$ApplicationErrorCopyWithImpl<$Res>
    implements $ApplicationErrorCopyWith<$Res> {
  _$ApplicationErrorCopyWithImpl(this._self, this._then);

  final ApplicationError _self;
  final $Res Function(ApplicationError) _then;

/// Create a copy of ApplicationError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as ApplicationErrorCode,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationError].
extension ApplicationErrorPatterns on ApplicationError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationError value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationError value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApplicationErrorCode code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationError() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApplicationErrorCode code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ApplicationError():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApplicationErrorCode code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationError() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ApplicationError implements ApplicationError {
  const _ApplicationError({required this.code, this.message});
  

@override final  ApplicationErrorCode code;
@override final  String? message;

/// Create a copy of ApplicationError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationErrorCopyWith<_ApplicationError> get copyWith => __$ApplicationErrorCopyWithImpl<_ApplicationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ApplicationError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ApplicationErrorCopyWith<$Res> implements $ApplicationErrorCopyWith<$Res> {
  factory _$ApplicationErrorCopyWith(_ApplicationError value, $Res Function(_ApplicationError) _then) = __$ApplicationErrorCopyWithImpl;
@override @useResult
$Res call({
 ApplicationErrorCode code, String? message
});




}
/// @nodoc
class __$ApplicationErrorCopyWithImpl<$Res>
    implements _$ApplicationErrorCopyWith<$Res> {
  __$ApplicationErrorCopyWithImpl(this._self, this._then);

  final _ApplicationError _self;
  final $Res Function(_ApplicationError) _then;

/// Create a copy of ApplicationError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = freezed,}) {
  return _then(_ApplicationError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as ApplicationErrorCode,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
