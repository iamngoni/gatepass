// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_sign_in_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FirebaseSignInResponseDTO {

 String? get idToken; String? get refreshToken;/// Seconds, as text.
 String? get expiresIn; String? get localId;
/// Create a copy of FirebaseSignInResponseDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirebaseSignInResponseDTOCopyWith<FirebaseSignInResponseDTO> get copyWith => _$FirebaseSignInResponseDTOCopyWithImpl<FirebaseSignInResponseDTO>(this as FirebaseSignInResponseDTO, _$identity);

  /// Serializes this FirebaseSignInResponseDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirebaseSignInResponseDTO&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.localId, localId) || other.localId == localId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,refreshToken,expiresIn,localId);

@override
String toString() {
  return 'FirebaseSignInResponseDTO(idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, localId: $localId)';
}


}

/// @nodoc
abstract mixin class $FirebaseSignInResponseDTOCopyWith<$Res>  {
  factory $FirebaseSignInResponseDTOCopyWith(FirebaseSignInResponseDTO value, $Res Function(FirebaseSignInResponseDTO) _then) = _$FirebaseSignInResponseDTOCopyWithImpl;
@useResult
$Res call({
 String? idToken, String? refreshToken, String? expiresIn, String? localId
});




}
/// @nodoc
class _$FirebaseSignInResponseDTOCopyWithImpl<$Res>
    implements $FirebaseSignInResponseDTOCopyWith<$Res> {
  _$FirebaseSignInResponseDTOCopyWithImpl(this._self, this._then);

  final FirebaseSignInResponseDTO _self;
  final $Res Function(FirebaseSignInResponseDTO) _then;

/// Create a copy of FirebaseSignInResponseDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idToken = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? localId = freezed,}) {
  return _then(_self.copyWith(
idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as String?,localId: freezed == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FirebaseSignInResponseDTO].
extension FirebaseSignInResponseDTOPatterns on FirebaseSignInResponseDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirebaseSignInResponseDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirebaseSignInResponseDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirebaseSignInResponseDTO value)  $default,){
final _that = this;
switch (_that) {
case _FirebaseSignInResponseDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirebaseSignInResponseDTO value)?  $default,){
final _that = this;
switch (_that) {
case _FirebaseSignInResponseDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? idToken,  String? refreshToken,  String? expiresIn,  String? localId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirebaseSignInResponseDTO() when $default != null:
return $default(_that.idToken,_that.refreshToken,_that.expiresIn,_that.localId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? idToken,  String? refreshToken,  String? expiresIn,  String? localId)  $default,) {final _that = this;
switch (_that) {
case _FirebaseSignInResponseDTO():
return $default(_that.idToken,_that.refreshToken,_that.expiresIn,_that.localId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? idToken,  String? refreshToken,  String? expiresIn,  String? localId)?  $default,) {final _that = this;
switch (_that) {
case _FirebaseSignInResponseDTO() when $default != null:
return $default(_that.idToken,_that.refreshToken,_that.expiresIn,_that.localId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FirebaseSignInResponseDTO implements FirebaseSignInResponseDTO {
  const _FirebaseSignInResponseDTO({this.idToken, this.refreshToken, this.expiresIn, this.localId});
  factory _FirebaseSignInResponseDTO.fromJson(Map<String, dynamic> json) => _$FirebaseSignInResponseDTOFromJson(json);

@override final  String? idToken;
@override final  String? refreshToken;
/// Seconds, as text.
@override final  String? expiresIn;
@override final  String? localId;

/// Create a copy of FirebaseSignInResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirebaseSignInResponseDTOCopyWith<_FirebaseSignInResponseDTO> get copyWith => __$FirebaseSignInResponseDTOCopyWithImpl<_FirebaseSignInResponseDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FirebaseSignInResponseDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirebaseSignInResponseDTO&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.localId, localId) || other.localId == localId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,refreshToken,expiresIn,localId);

@override
String toString() {
  return 'FirebaseSignInResponseDTO(idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, localId: $localId)';
}


}

/// @nodoc
abstract mixin class _$FirebaseSignInResponseDTOCopyWith<$Res> implements $FirebaseSignInResponseDTOCopyWith<$Res> {
  factory _$FirebaseSignInResponseDTOCopyWith(_FirebaseSignInResponseDTO value, $Res Function(_FirebaseSignInResponseDTO) _then) = __$FirebaseSignInResponseDTOCopyWithImpl;
@override @useResult
$Res call({
 String? idToken, String? refreshToken, String? expiresIn, String? localId
});




}
/// @nodoc
class __$FirebaseSignInResponseDTOCopyWithImpl<$Res>
    implements _$FirebaseSignInResponseDTOCopyWith<$Res> {
  __$FirebaseSignInResponseDTOCopyWithImpl(this._self, this._then);

  final _FirebaseSignInResponseDTO _self;
  final $Res Function(_FirebaseSignInResponseDTO) _then;

/// Create a copy of FirebaseSignInResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idToken = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? localId = freezed,}) {
  return _then(_FirebaseSignInResponseDTO(
idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as String?,localId: freezed == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
