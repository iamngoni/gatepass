// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettingsDTO {

@JsonKey(readValue: _readBrand) String? get estateName;@JsonKey(readValue: _readUnit) String? get unit;@JsonKey(readValue: _readFirstName) String? get firstName;@JsonKey(readValue: _readLastName) String? get lastName;@JsonKey(readValue: _readEmail) String? get email;@JsonKey(readValue: _readHorizon) int? get inviteHorizonDays;
/// Create a copy of UserSettingsDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsDTOCopyWith<UserSettingsDTO> get copyWith => _$UserSettingsDTOCopyWithImpl<UserSettingsDTO>(this as UserSettingsDTO, _$identity);

  /// Serializes this UserSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsDTO&&(identical(other.estateName, estateName) || other.estateName == estateName)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.inviteHorizonDays, inviteHorizonDays) || other.inviteHorizonDays == inviteHorizonDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estateName,unit,firstName,lastName,email,inviteHorizonDays);

@override
String toString() {
  return 'UserSettingsDTO(estateName: $estateName, unit: $unit, firstName: $firstName, lastName: $lastName, email: $email, inviteHorizonDays: $inviteHorizonDays)';
}


}

/// @nodoc
abstract mixin class $UserSettingsDTOCopyWith<$Res>  {
  factory $UserSettingsDTOCopyWith(UserSettingsDTO value, $Res Function(UserSettingsDTO) _then) = _$UserSettingsDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readBrand) String? estateName,@JsonKey(readValue: _readUnit) String? unit,@JsonKey(readValue: _readFirstName) String? firstName,@JsonKey(readValue: _readLastName) String? lastName,@JsonKey(readValue: _readEmail) String? email,@JsonKey(readValue: _readHorizon) int? inviteHorizonDays
});




}
/// @nodoc
class _$UserSettingsDTOCopyWithImpl<$Res>
    implements $UserSettingsDTOCopyWith<$Res> {
  _$UserSettingsDTOCopyWithImpl(this._self, this._then);

  final UserSettingsDTO _self;
  final $Res Function(UserSettingsDTO) _then;

/// Create a copy of UserSettingsDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estateName = freezed,Object? unit = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? inviteHorizonDays = freezed,}) {
  return _then(_self.copyWith(
estateName: freezed == estateName ? _self.estateName : estateName // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,inviteHorizonDays: freezed == inviteHorizonDays ? _self.inviteHorizonDays : inviteHorizonDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettingsDTO].
extension UserSettingsDTOPatterns on UserSettingsDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettingsDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettingsDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettingsDTO value)  $default,){
final _that = this;
switch (_that) {
case _UserSettingsDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettingsDTO value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettingsDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readBrand)  String? estateName, @JsonKey(readValue: _readUnit)  String? unit, @JsonKey(readValue: _readFirstName)  String? firstName, @JsonKey(readValue: _readLastName)  String? lastName, @JsonKey(readValue: _readEmail)  String? email, @JsonKey(readValue: _readHorizon)  int? inviteHorizonDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettingsDTO() when $default != null:
return $default(_that.estateName,_that.unit,_that.firstName,_that.lastName,_that.email,_that.inviteHorizonDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readBrand)  String? estateName, @JsonKey(readValue: _readUnit)  String? unit, @JsonKey(readValue: _readFirstName)  String? firstName, @JsonKey(readValue: _readLastName)  String? lastName, @JsonKey(readValue: _readEmail)  String? email, @JsonKey(readValue: _readHorizon)  int? inviteHorizonDays)  $default,) {final _that = this;
switch (_that) {
case _UserSettingsDTO():
return $default(_that.estateName,_that.unit,_that.firstName,_that.lastName,_that.email,_that.inviteHorizonDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readBrand)  String? estateName, @JsonKey(readValue: _readUnit)  String? unit, @JsonKey(readValue: _readFirstName)  String? firstName, @JsonKey(readValue: _readLastName)  String? lastName, @JsonKey(readValue: _readEmail)  String? email, @JsonKey(readValue: _readHorizon)  int? inviteHorizonDays)?  $default,) {final _that = this;
switch (_that) {
case _UserSettingsDTO() when $default != null:
return $default(_that.estateName,_that.unit,_that.firstName,_that.lastName,_that.email,_that.inviteHorizonDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSettingsDTO extends UserSettingsDTO {
  const _UserSettingsDTO({@JsonKey(readValue: _readBrand) this.estateName, @JsonKey(readValue: _readUnit) this.unit, @JsonKey(readValue: _readFirstName) this.firstName, @JsonKey(readValue: _readLastName) this.lastName, @JsonKey(readValue: _readEmail) this.email, @JsonKey(readValue: _readHorizon) this.inviteHorizonDays}): super._();
  factory _UserSettingsDTO.fromJson(Map<String, dynamic> json) => _$UserSettingsDTOFromJson(json);

@override@JsonKey(readValue: _readBrand) final  String? estateName;
@override@JsonKey(readValue: _readUnit) final  String? unit;
@override@JsonKey(readValue: _readFirstName) final  String? firstName;
@override@JsonKey(readValue: _readLastName) final  String? lastName;
@override@JsonKey(readValue: _readEmail) final  String? email;
@override@JsonKey(readValue: _readHorizon) final  int? inviteHorizonDays;

/// Create a copy of UserSettingsDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsDTOCopyWith<_UserSettingsDTO> get copyWith => __$UserSettingsDTOCopyWithImpl<_UserSettingsDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSettingsDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettingsDTO&&(identical(other.estateName, estateName) || other.estateName == estateName)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.inviteHorizonDays, inviteHorizonDays) || other.inviteHorizonDays == inviteHorizonDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estateName,unit,firstName,lastName,email,inviteHorizonDays);

@override
String toString() {
  return 'UserSettingsDTO(estateName: $estateName, unit: $unit, firstName: $firstName, lastName: $lastName, email: $email, inviteHorizonDays: $inviteHorizonDays)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsDTOCopyWith<$Res> implements $UserSettingsDTOCopyWith<$Res> {
  factory _$UserSettingsDTOCopyWith(_UserSettingsDTO value, $Res Function(_UserSettingsDTO) _then) = __$UserSettingsDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readBrand) String? estateName,@JsonKey(readValue: _readUnit) String? unit,@JsonKey(readValue: _readFirstName) String? firstName,@JsonKey(readValue: _readLastName) String? lastName,@JsonKey(readValue: _readEmail) String? email,@JsonKey(readValue: _readHorizon) int? inviteHorizonDays
});




}
/// @nodoc
class __$UserSettingsDTOCopyWithImpl<$Res>
    implements _$UserSettingsDTOCopyWith<$Res> {
  __$UserSettingsDTOCopyWithImpl(this._self, this._then);

  final _UserSettingsDTO _self;
  final $Res Function(_UserSettingsDTO) _then;

/// Create a copy of UserSettingsDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estateName = freezed,Object? unit = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? inviteHorizonDays = freezed,}) {
  return _then(_UserSettingsDTO(
estateName: freezed == estateName ? _self.estateName : estateName // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,inviteHorizonDays: freezed == inviteHorizonDays ? _self.inviteHorizonDays : inviteHorizonDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
