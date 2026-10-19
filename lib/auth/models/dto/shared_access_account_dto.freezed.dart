// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_access_account_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedAccessAccountDTO {

@JsonKey(readValue: _readHostUid) String? get hostUid;@JsonKey(readValue: _readEstate) String? get estateName;@JsonKey(readValue: _readUnit) String? get unit;@JsonKey(readValue: _readName) String? get residentName;@JsonKey(readValue: _readEmail) String? get email;
/// Create a copy of SharedAccessAccountDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedAccessAccountDTOCopyWith<SharedAccessAccountDTO> get copyWith => _$SharedAccessAccountDTOCopyWithImpl<SharedAccessAccountDTO>(this as SharedAccessAccountDTO, _$identity);

  /// Serializes this SharedAccessAccountDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedAccessAccountDTO&&(identical(other.hostUid, hostUid) || other.hostUid == hostUid)&&(identical(other.estateName, estateName) || other.estateName == estateName)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.residentName, residentName) || other.residentName == residentName)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hostUid,estateName,unit,residentName,email);

@override
String toString() {
  return 'SharedAccessAccountDTO(hostUid: $hostUid, estateName: $estateName, unit: $unit, residentName: $residentName, email: $email)';
}


}

/// @nodoc
abstract mixin class $SharedAccessAccountDTOCopyWith<$Res>  {
  factory $SharedAccessAccountDTOCopyWith(SharedAccessAccountDTO value, $Res Function(SharedAccessAccountDTO) _then) = _$SharedAccessAccountDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readHostUid) String? hostUid,@JsonKey(readValue: _readEstate) String? estateName,@JsonKey(readValue: _readUnit) String? unit,@JsonKey(readValue: _readName) String? residentName,@JsonKey(readValue: _readEmail) String? email
});




}
/// @nodoc
class _$SharedAccessAccountDTOCopyWithImpl<$Res>
    implements $SharedAccessAccountDTOCopyWith<$Res> {
  _$SharedAccessAccountDTOCopyWithImpl(this._self, this._then);

  final SharedAccessAccountDTO _self;
  final $Res Function(SharedAccessAccountDTO) _then;

/// Create a copy of SharedAccessAccountDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hostUid = freezed,Object? estateName = freezed,Object? unit = freezed,Object? residentName = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
hostUid: freezed == hostUid ? _self.hostUid : hostUid // ignore: cast_nullable_to_non_nullable
as String?,estateName: freezed == estateName ? _self.estateName : estateName // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,residentName: freezed == residentName ? _self.residentName : residentName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedAccessAccountDTO].
extension SharedAccessAccountDTOPatterns on SharedAccessAccountDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedAccessAccountDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedAccessAccountDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedAccessAccountDTO value)  $default,){
final _that = this;
switch (_that) {
case _SharedAccessAccountDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedAccessAccountDTO value)?  $default,){
final _that = this;
switch (_that) {
case _SharedAccessAccountDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readHostUid)  String? hostUid, @JsonKey(readValue: _readEstate)  String? estateName, @JsonKey(readValue: _readUnit)  String? unit, @JsonKey(readValue: _readName)  String? residentName, @JsonKey(readValue: _readEmail)  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedAccessAccountDTO() when $default != null:
return $default(_that.hostUid,_that.estateName,_that.unit,_that.residentName,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readHostUid)  String? hostUid, @JsonKey(readValue: _readEstate)  String? estateName, @JsonKey(readValue: _readUnit)  String? unit, @JsonKey(readValue: _readName)  String? residentName, @JsonKey(readValue: _readEmail)  String? email)  $default,) {final _that = this;
switch (_that) {
case _SharedAccessAccountDTO():
return $default(_that.hostUid,_that.estateName,_that.unit,_that.residentName,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readHostUid)  String? hostUid, @JsonKey(readValue: _readEstate)  String? estateName, @JsonKey(readValue: _readUnit)  String? unit, @JsonKey(readValue: _readName)  String? residentName, @JsonKey(readValue: _readEmail)  String? email)?  $default,) {final _that = this;
switch (_that) {
case _SharedAccessAccountDTO() when $default != null:
return $default(_that.hostUid,_that.estateName,_that.unit,_that.residentName,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedAccessAccountDTO implements SharedAccessAccountDTO {
  const _SharedAccessAccountDTO({@JsonKey(readValue: _readHostUid) this.hostUid, @JsonKey(readValue: _readEstate) this.estateName, @JsonKey(readValue: _readUnit) this.unit, @JsonKey(readValue: _readName) this.residentName, @JsonKey(readValue: _readEmail) this.email});
  factory _SharedAccessAccountDTO.fromJson(Map<String, dynamic> json) => _$SharedAccessAccountDTOFromJson(json);

@override@JsonKey(readValue: _readHostUid) final  String? hostUid;
@override@JsonKey(readValue: _readEstate) final  String? estateName;
@override@JsonKey(readValue: _readUnit) final  String? unit;
@override@JsonKey(readValue: _readName) final  String? residentName;
@override@JsonKey(readValue: _readEmail) final  String? email;

/// Create a copy of SharedAccessAccountDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedAccessAccountDTOCopyWith<_SharedAccessAccountDTO> get copyWith => __$SharedAccessAccountDTOCopyWithImpl<_SharedAccessAccountDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedAccessAccountDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedAccessAccountDTO&&(identical(other.hostUid, hostUid) || other.hostUid == hostUid)&&(identical(other.estateName, estateName) || other.estateName == estateName)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.residentName, residentName) || other.residentName == residentName)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hostUid,estateName,unit,residentName,email);

@override
String toString() {
  return 'SharedAccessAccountDTO(hostUid: $hostUid, estateName: $estateName, unit: $unit, residentName: $residentName, email: $email)';
}


}

/// @nodoc
abstract mixin class _$SharedAccessAccountDTOCopyWith<$Res> implements $SharedAccessAccountDTOCopyWith<$Res> {
  factory _$SharedAccessAccountDTOCopyWith(_SharedAccessAccountDTO value, $Res Function(_SharedAccessAccountDTO) _then) = __$SharedAccessAccountDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readHostUid) String? hostUid,@JsonKey(readValue: _readEstate) String? estateName,@JsonKey(readValue: _readUnit) String? unit,@JsonKey(readValue: _readName) String? residentName,@JsonKey(readValue: _readEmail) String? email
});




}
/// @nodoc
class __$SharedAccessAccountDTOCopyWithImpl<$Res>
    implements _$SharedAccessAccountDTOCopyWith<$Res> {
  __$SharedAccessAccountDTOCopyWithImpl(this._self, this._then);

  final _SharedAccessAccountDTO _self;
  final $Res Function(_SharedAccessAccountDTO) _then;

/// Create a copy of SharedAccessAccountDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hostUid = freezed,Object? estateName = freezed,Object? unit = freezed,Object? residentName = freezed,Object? email = freezed,}) {
  return _then(_SharedAccessAccountDTO(
hostUid: freezed == hostUid ? _self.hostUid : hostUid // ignore: cast_nullable_to_non_nullable
as String?,estateName: freezed == estateName ? _self.estateName : estateName // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,residentName: freezed == residentName ? _self.residentName : residentName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
