// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_check_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginCheckResponseDTO {

@JsonKey(readValue: _readCustomToken) String? get customToken;
/// Create a copy of LoginCheckResponseDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginCheckResponseDTOCopyWith<LoginCheckResponseDTO> get copyWith => _$LoginCheckResponseDTOCopyWithImpl<LoginCheckResponseDTO>(this as LoginCheckResponseDTO, _$identity);

  /// Serializes this LoginCheckResponseDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginCheckResponseDTO&&(identical(other.customToken, customToken) || other.customToken == customToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customToken);

@override
String toString() {
  return 'LoginCheckResponseDTO(customToken: $customToken)';
}


}

/// @nodoc
abstract mixin class $LoginCheckResponseDTOCopyWith<$Res>  {
  factory $LoginCheckResponseDTOCopyWith(LoginCheckResponseDTO value, $Res Function(LoginCheckResponseDTO) _then) = _$LoginCheckResponseDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readCustomToken) String? customToken
});




}
/// @nodoc
class _$LoginCheckResponseDTOCopyWithImpl<$Res>
    implements $LoginCheckResponseDTOCopyWith<$Res> {
  _$LoginCheckResponseDTOCopyWithImpl(this._self, this._then);

  final LoginCheckResponseDTO _self;
  final $Res Function(LoginCheckResponseDTO) _then;

/// Create a copy of LoginCheckResponseDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customToken = freezed,}) {
  return _then(_self.copyWith(
customToken: freezed == customToken ? _self.customToken : customToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginCheckResponseDTO].
extension LoginCheckResponseDTOPatterns on LoginCheckResponseDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginCheckResponseDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginCheckResponseDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginCheckResponseDTO value)  $default,){
final _that = this;
switch (_that) {
case _LoginCheckResponseDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginCheckResponseDTO value)?  $default,){
final _that = this;
switch (_that) {
case _LoginCheckResponseDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readCustomToken)  String? customToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginCheckResponseDTO() when $default != null:
return $default(_that.customToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readCustomToken)  String? customToken)  $default,) {final _that = this;
switch (_that) {
case _LoginCheckResponseDTO():
return $default(_that.customToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readCustomToken)  String? customToken)?  $default,) {final _that = this;
switch (_that) {
case _LoginCheckResponseDTO() when $default != null:
return $default(_that.customToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginCheckResponseDTO implements LoginCheckResponseDTO {
  const _LoginCheckResponseDTO({@JsonKey(readValue: _readCustomToken) this.customToken});
  factory _LoginCheckResponseDTO.fromJson(Map<String, dynamic> json) => _$LoginCheckResponseDTOFromJson(json);

@override@JsonKey(readValue: _readCustomToken) final  String? customToken;

/// Create a copy of LoginCheckResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginCheckResponseDTOCopyWith<_LoginCheckResponseDTO> get copyWith => __$LoginCheckResponseDTOCopyWithImpl<_LoginCheckResponseDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginCheckResponseDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginCheckResponseDTO&&(identical(other.customToken, customToken) || other.customToken == customToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customToken);

@override
String toString() {
  return 'LoginCheckResponseDTO(customToken: $customToken)';
}


}

/// @nodoc
abstract mixin class _$LoginCheckResponseDTOCopyWith<$Res> implements $LoginCheckResponseDTOCopyWith<$Res> {
  factory _$LoginCheckResponseDTOCopyWith(_LoginCheckResponseDTO value, $Res Function(_LoginCheckResponseDTO) _then) = __$LoginCheckResponseDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readCustomToken) String? customToken
});




}
/// @nodoc
class __$LoginCheckResponseDTOCopyWithImpl<$Res>
    implements _$LoginCheckResponseDTOCopyWith<$Res> {
  __$LoginCheckResponseDTOCopyWithImpl(this._self, this._then);

  final _LoginCheckResponseDTO _self;
  final $Res Function(_LoginCheckResponseDTO) _then;

/// Create a copy of LoginCheckResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customToken = freezed,}) {
  return _then(_LoginCheckResponseDTO(
customToken: freezed == customToken ? _self.customToken : customToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
