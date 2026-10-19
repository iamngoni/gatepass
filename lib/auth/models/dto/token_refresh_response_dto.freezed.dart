// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_refresh_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenRefreshResponseDTO {

@JsonKey(readValue: _readIdToken) String? get idToken;@JsonKey(name: 'refresh_token') String? get refreshToken;/// Seconds, as text.
@JsonKey(name: 'expires_in') String? get expiresIn;@JsonKey(name: 'user_id') String? get userId;
/// Create a copy of TokenRefreshResponseDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenRefreshResponseDTOCopyWith<TokenRefreshResponseDTO> get copyWith => _$TokenRefreshResponseDTOCopyWithImpl<TokenRefreshResponseDTO>(this as TokenRefreshResponseDTO, _$identity);

  /// Serializes this TokenRefreshResponseDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenRefreshResponseDTO&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,refreshToken,expiresIn,userId);

@override
String toString() {
  return 'TokenRefreshResponseDTO(idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $TokenRefreshResponseDTOCopyWith<$Res>  {
  factory $TokenRefreshResponseDTOCopyWith(TokenRefreshResponseDTO value, $Res Function(TokenRefreshResponseDTO) _then) = _$TokenRefreshResponseDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readIdToken) String? idToken,@JsonKey(name: 'refresh_token') String? refreshToken,@JsonKey(name: 'expires_in') String? expiresIn,@JsonKey(name: 'user_id') String? userId
});




}
/// @nodoc
class _$TokenRefreshResponseDTOCopyWithImpl<$Res>
    implements $TokenRefreshResponseDTOCopyWith<$Res> {
  _$TokenRefreshResponseDTOCopyWithImpl(this._self, this._then);

  final TokenRefreshResponseDTO _self;
  final $Res Function(TokenRefreshResponseDTO) _then;

/// Create a copy of TokenRefreshResponseDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idToken = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? userId = freezed,}) {
  return _then(_self.copyWith(
idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenRefreshResponseDTO].
extension TokenRefreshResponseDTOPatterns on TokenRefreshResponseDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenRefreshResponseDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenRefreshResponseDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenRefreshResponseDTO value)  $default,){
final _that = this;
switch (_that) {
case _TokenRefreshResponseDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenRefreshResponseDTO value)?  $default,){
final _that = this;
switch (_that) {
case _TokenRefreshResponseDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readIdToken)  String? idToken, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  String? expiresIn, @JsonKey(name: 'user_id')  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenRefreshResponseDTO() when $default != null:
return $default(_that.idToken,_that.refreshToken,_that.expiresIn,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readIdToken)  String? idToken, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  String? expiresIn, @JsonKey(name: 'user_id')  String? userId)  $default,) {final _that = this;
switch (_that) {
case _TokenRefreshResponseDTO():
return $default(_that.idToken,_that.refreshToken,_that.expiresIn,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readIdToken)  String? idToken, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  String? expiresIn, @JsonKey(name: 'user_id')  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _TokenRefreshResponseDTO() when $default != null:
return $default(_that.idToken,_that.refreshToken,_that.expiresIn,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenRefreshResponseDTO implements TokenRefreshResponseDTO {
  const _TokenRefreshResponseDTO({@JsonKey(readValue: _readIdToken) this.idToken, @JsonKey(name: 'refresh_token') this.refreshToken, @JsonKey(name: 'expires_in') this.expiresIn, @JsonKey(name: 'user_id') this.userId});
  factory _TokenRefreshResponseDTO.fromJson(Map<String, dynamic> json) => _$TokenRefreshResponseDTOFromJson(json);

@override@JsonKey(readValue: _readIdToken) final  String? idToken;
@override@JsonKey(name: 'refresh_token') final  String? refreshToken;
/// Seconds, as text.
@override@JsonKey(name: 'expires_in') final  String? expiresIn;
@override@JsonKey(name: 'user_id') final  String? userId;

/// Create a copy of TokenRefreshResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenRefreshResponseDTOCopyWith<_TokenRefreshResponseDTO> get copyWith => __$TokenRefreshResponseDTOCopyWithImpl<_TokenRefreshResponseDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenRefreshResponseDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenRefreshResponseDTO&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,refreshToken,expiresIn,userId);

@override
String toString() {
  return 'TokenRefreshResponseDTO(idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$TokenRefreshResponseDTOCopyWith<$Res> implements $TokenRefreshResponseDTOCopyWith<$Res> {
  factory _$TokenRefreshResponseDTOCopyWith(_TokenRefreshResponseDTO value, $Res Function(_TokenRefreshResponseDTO) _then) = __$TokenRefreshResponseDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readIdToken) String? idToken,@JsonKey(name: 'refresh_token') String? refreshToken,@JsonKey(name: 'expires_in') String? expiresIn,@JsonKey(name: 'user_id') String? userId
});




}
/// @nodoc
class __$TokenRefreshResponseDTOCopyWithImpl<$Res>
    implements _$TokenRefreshResponseDTOCopyWith<$Res> {
  __$TokenRefreshResponseDTOCopyWithImpl(this._self, this._then);

  final _TokenRefreshResponseDTO _self;
  final $Res Function(_TokenRefreshResponseDTO) _then;

/// Create a copy of TokenRefreshResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idToken = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? userId = freezed,}) {
  return _then(_TokenRefreshResponseDTO(
idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
