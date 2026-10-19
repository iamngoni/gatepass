// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_token_exchange_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomTokenExchangeDTO {

 String get token; bool get returnSecureToken;
/// Create a copy of CustomTokenExchangeDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomTokenExchangeDTOCopyWith<CustomTokenExchangeDTO> get copyWith => _$CustomTokenExchangeDTOCopyWithImpl<CustomTokenExchangeDTO>(this as CustomTokenExchangeDTO, _$identity);

  /// Serializes this CustomTokenExchangeDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomTokenExchangeDTO&&(identical(other.token, token) || other.token == token)&&(identical(other.returnSecureToken, returnSecureToken) || other.returnSecureToken == returnSecureToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,returnSecureToken);

@override
String toString() {
  return 'CustomTokenExchangeDTO(token: $token, returnSecureToken: $returnSecureToken)';
}


}

/// @nodoc
abstract mixin class $CustomTokenExchangeDTOCopyWith<$Res>  {
  factory $CustomTokenExchangeDTOCopyWith(CustomTokenExchangeDTO value, $Res Function(CustomTokenExchangeDTO) _then) = _$CustomTokenExchangeDTOCopyWithImpl;
@useResult
$Res call({
 String token, bool returnSecureToken
});




}
/// @nodoc
class _$CustomTokenExchangeDTOCopyWithImpl<$Res>
    implements $CustomTokenExchangeDTOCopyWith<$Res> {
  _$CustomTokenExchangeDTOCopyWithImpl(this._self, this._then);

  final CustomTokenExchangeDTO _self;
  final $Res Function(CustomTokenExchangeDTO) _then;

/// Create a copy of CustomTokenExchangeDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? returnSecureToken = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,returnSecureToken: null == returnSecureToken ? _self.returnSecureToken : returnSecureToken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomTokenExchangeDTO].
extension CustomTokenExchangeDTOPatterns on CustomTokenExchangeDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomTokenExchangeDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomTokenExchangeDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomTokenExchangeDTO value)  $default,){
final _that = this;
switch (_that) {
case _CustomTokenExchangeDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomTokenExchangeDTO value)?  $default,){
final _that = this;
switch (_that) {
case _CustomTokenExchangeDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  bool returnSecureToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomTokenExchangeDTO() when $default != null:
return $default(_that.token,_that.returnSecureToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  bool returnSecureToken)  $default,) {final _that = this;
switch (_that) {
case _CustomTokenExchangeDTO():
return $default(_that.token,_that.returnSecureToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  bool returnSecureToken)?  $default,) {final _that = this;
switch (_that) {
case _CustomTokenExchangeDTO() when $default != null:
return $default(_that.token,_that.returnSecureToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomTokenExchangeDTO implements CustomTokenExchangeDTO {
  const _CustomTokenExchangeDTO({required this.token, this.returnSecureToken = true});
  factory _CustomTokenExchangeDTO.fromJson(Map<String, dynamic> json) => _$CustomTokenExchangeDTOFromJson(json);

@override final  String token;
@override@JsonKey() final  bool returnSecureToken;

/// Create a copy of CustomTokenExchangeDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomTokenExchangeDTOCopyWith<_CustomTokenExchangeDTO> get copyWith => __$CustomTokenExchangeDTOCopyWithImpl<_CustomTokenExchangeDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomTokenExchangeDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomTokenExchangeDTO&&(identical(other.token, token) || other.token == token)&&(identical(other.returnSecureToken, returnSecureToken) || other.returnSecureToken == returnSecureToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,returnSecureToken);

@override
String toString() {
  return 'CustomTokenExchangeDTO(token: $token, returnSecureToken: $returnSecureToken)';
}


}

/// @nodoc
abstract mixin class _$CustomTokenExchangeDTOCopyWith<$Res> implements $CustomTokenExchangeDTOCopyWith<$Res> {
  factory _$CustomTokenExchangeDTOCopyWith(_CustomTokenExchangeDTO value, $Res Function(_CustomTokenExchangeDTO) _then) = __$CustomTokenExchangeDTOCopyWithImpl;
@override @useResult
$Res call({
 String token, bool returnSecureToken
});




}
/// @nodoc
class __$CustomTokenExchangeDTOCopyWithImpl<$Res>
    implements _$CustomTokenExchangeDTOCopyWith<$Res> {
  __$CustomTokenExchangeDTOCopyWithImpl(this._self, this._then);

  final _CustomTokenExchangeDTO _self;
  final $Res Function(_CustomTokenExchangeDTO) _then;

/// Create a copy of CustomTokenExchangeDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? returnSecureToken = null,}) {
  return _then(_CustomTokenExchangeDTO(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,returnSecureToken: null == returnSecureToken ? _self.returnSecureToken : returnSecureToken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
