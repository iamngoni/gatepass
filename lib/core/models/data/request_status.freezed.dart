// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestStatus<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestStatus<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestStatus<$T>()';
}


}

/// @nodoc
class $RequestStatusCopyWith<T,$Res>  {
$RequestStatusCopyWith(RequestStatus<T> _, $Res Function(RequestStatus<T>) __);
}


/// Adds pattern-matching-related methods to [RequestStatus].
extension RequestStatusPatterns<T> on RequestStatus<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RequestPending<T> value)?  pending,TResult Function( RequestSucceeded<T> value)?  succeeded,TResult Function( RequestFailed<T> value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RequestPending() when pending != null:
return pending(_that);case RequestSucceeded() when succeeded != null:
return succeeded(_that);case RequestFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RequestPending<T> value)  pending,required TResult Function( RequestSucceeded<T> value)  succeeded,required TResult Function( RequestFailed<T> value)  failed,}){
final _that = this;
switch (_that) {
case RequestPending():
return pending(_that);case RequestSucceeded():
return succeeded(_that);case RequestFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RequestPending<T> value)?  pending,TResult? Function( RequestSucceeded<T> value)?  succeeded,TResult? Function( RequestFailed<T> value)?  failed,}){
final _that = this;
switch (_that) {
case RequestPending() when pending != null:
return pending(_that);case RequestSucceeded() when succeeded != null:
return succeeded(_that);case RequestFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  pending,TResult Function( T value)?  succeeded,TResult Function( ApplicationError error)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RequestPending() when pending != null:
return pending();case RequestSucceeded() when succeeded != null:
return succeeded(_that.value);case RequestFailed() when failed != null:
return failed(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  pending,required TResult Function( T value)  succeeded,required TResult Function( ApplicationError error)  failed,}) {final _that = this;
switch (_that) {
case RequestPending():
return pending();case RequestSucceeded():
return succeeded(_that.value);case RequestFailed():
return failed(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  pending,TResult? Function( T value)?  succeeded,TResult? Function( ApplicationError error)?  failed,}) {final _that = this;
switch (_that) {
case RequestPending() when pending != null:
return pending();case RequestSucceeded() when succeeded != null:
return succeeded(_that.value);case RequestFailed() when failed != null:
return failed(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class RequestPending<T> implements RequestStatus<T> {
  const RequestPending();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestPending<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestStatus<$T>.pending()';
}


}




/// @nodoc


class RequestSucceeded<T> implements RequestStatus<T> {
  const RequestSucceeded(this.value);
  

 final  T value;

/// Create a copy of RequestStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestSucceededCopyWith<T, RequestSucceeded<T>> get copyWith => _$RequestSucceededCopyWithImpl<T, RequestSucceeded<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestSucceeded<T>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'RequestStatus<$T>.succeeded(value: $value)';
}


}

/// @nodoc
abstract mixin class $RequestSucceededCopyWith<T,$Res> implements $RequestStatusCopyWith<T, $Res> {
  factory $RequestSucceededCopyWith(RequestSucceeded<T> value, $Res Function(RequestSucceeded<T>) _then) = _$RequestSucceededCopyWithImpl;
@useResult
$Res call({
 T value
});




}
/// @nodoc
class _$RequestSucceededCopyWithImpl<T,$Res>
    implements $RequestSucceededCopyWith<T, $Res> {
  _$RequestSucceededCopyWithImpl(this._self, this._then);

  final RequestSucceeded<T> _self;
  final $Res Function(RequestSucceeded<T>) _then;

/// Create a copy of RequestStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(RequestSucceeded<T>(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class RequestFailed<T> implements RequestStatus<T> {
  const RequestFailed(this.error);
  

 final  ApplicationError error;

/// Create a copy of RequestStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestFailedCopyWith<T, RequestFailed<T>> get copyWith => _$RequestFailedCopyWithImpl<T, RequestFailed<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestFailed<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'RequestStatus<$T>.failed(error: $error)';
}


}

/// @nodoc
abstract mixin class $RequestFailedCopyWith<T,$Res> implements $RequestStatusCopyWith<T, $Res> {
  factory $RequestFailedCopyWith(RequestFailed<T> value, $Res Function(RequestFailed<T>) _then) = _$RequestFailedCopyWithImpl;
@useResult
$Res call({
 ApplicationError error
});


$ApplicationErrorCopyWith<$Res> get error;

}
/// @nodoc
class _$RequestFailedCopyWithImpl<T,$Res>
    implements $RequestFailedCopyWith<T, $Res> {
  _$RequestFailedCopyWithImpl(this._self, this._then);

  final RequestFailed<T> _self;
  final $Res Function(RequestFailed<T>) _then;

/// Create a copy of RequestStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(RequestFailed<T>(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApplicationError,
  ));
}

/// Create a copy of RequestStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationErrorCopyWith<$Res> get error {
  
  return $ApplicationErrorCopyWith<$Res>(_self.error, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
