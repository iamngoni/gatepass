// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_refresh_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenRefreshDTO {

@JsonKey(name: 'refresh_token') String get refreshToken;@JsonKey(name: 'grant_type') String get grantType;
/// Create a copy of TokenRefreshDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenRefreshDTOCopyWith<TokenRefreshDTO> get copyWith => _$TokenRefreshDTOCopyWithImpl<TokenRefreshDTO>(this as TokenRefreshDTO, _$identity);

  /// Serializes this TokenRefreshDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenRefreshDTO&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.grantType, grantType) || other.grantType == grantType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken,grantType);

@override
String toString() {
  return 'TokenRefreshDTO(refreshToken: $refreshToken, grantType: $grantType)';
}


}

/// @nodoc
abstract mixin class $TokenRefreshDTOCopyWith<$Res>  {
  factory $TokenRefreshDTOCopyWith(TokenRefreshDTO value, $Res Function(TokenRefreshDTO) _then) = _$TokenRefreshDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'grant_type') String grantType
});




}
/// @nodoc
class _$TokenRefreshDTOCopyWithImpl<$Res>
    implements $TokenRefreshDTOCopyWith<$Res> {
  _$TokenRefreshDTOCopyWithImpl(this._self, this._then);

  final TokenRefreshDTO _self;
  final $Res Function(TokenRefreshDTO) _then;

/// Create a copy of TokenRefreshDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? refreshToken = null,Object? grantType = null,}) {
  return _then(_self.copyWith(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,grantType: null == grantType ? _self.grantType : grantType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenRefreshDTO].
extension TokenRefreshDTOPatterns on TokenRefreshDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenRefreshDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenRefreshDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenRefreshDTO value)  $default,){
final _that = this;
switch (_that) {
case _TokenRefreshDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenRefreshDTO value)?  $default,){
final _that = this;
switch (_that) {
case _TokenRefreshDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'grant_type')  String grantType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenRefreshDTO() when $default != null:
return $default(_that.refreshToken,_that.grantType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'grant_type')  String grantType)  $default,) {final _that = this;
switch (_that) {
case _TokenRefreshDTO():
return $default(_that.refreshToken,_that.grantType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'grant_type')  String grantType)?  $default,) {final _that = this;
switch (_that) {
case _TokenRefreshDTO() when $default != null:
return $default(_that.refreshToken,_that.grantType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenRefreshDTO implements TokenRefreshDTO {
  const _TokenRefreshDTO({@JsonKey(name: 'refresh_token') required this.refreshToken, @JsonKey(name: 'grant_type') this.grantType = 'refresh_token'});
  factory _TokenRefreshDTO.fromJson(Map<String, dynamic> json) => _$TokenRefreshDTOFromJson(json);

@override@JsonKey(name: 'refresh_token') final  String refreshToken;
@override@JsonKey(name: 'grant_type') final  String grantType;

/// Create a copy of TokenRefreshDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenRefreshDTOCopyWith<_TokenRefreshDTO> get copyWith => __$TokenRefreshDTOCopyWithImpl<_TokenRefreshDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenRefreshDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenRefreshDTO&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.grantType, grantType) || other.grantType == grantType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken,grantType);

@override
String toString() {
  return 'TokenRefreshDTO(refreshToken: $refreshToken, grantType: $grantType)';
}


}

/// @nodoc
abstract mixin class _$TokenRefreshDTOCopyWith<$Res> implements $TokenRefreshDTOCopyWith<$Res> {
  factory _$TokenRefreshDTOCopyWith(_TokenRefreshDTO value, $Res Function(_TokenRefreshDTO) _then) = __$TokenRefreshDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'grant_type') String grantType
});




}
/// @nodoc
class __$TokenRefreshDTOCopyWithImpl<$Res>
    implements _$TokenRefreshDTOCopyWith<$Res> {
  __$TokenRefreshDTOCopyWithImpl(this._self, this._then);

  final _TokenRefreshDTO _self;
  final $Res Function(_TokenRefreshDTO) _then;

/// Create a copy of TokenRefreshDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refreshToken = null,Object? grantType = null,}) {
  return _then(_TokenRefreshDTO(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,grantType: null == grantType ? _self.grantType : grantType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
