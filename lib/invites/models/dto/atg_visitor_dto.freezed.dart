// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atg_visitor_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AtgVisitorDTO {

/// The per-invite record id. `uid` is the estate host uid shared by
/// every visitor record, so it is the last resort.
@JsonKey(readValue: _readId) String? get id;@JsonKey(readValue: _readFullName) String? get fullName;@JsonKey(readValue: _readFirstName) String? get firstName;@JsonKey(readValue: _readLastName) String? get lastName;@JsonKey(readValue: _readPhone) String? get phone;@JsonKey(readValue: _readVehicle) String? get vehicleReg;@AtgDateConverter()@JsonKey(readValue: _readFrom) DateTime? get validFrom;@AtgDateConverter()@JsonKey(readValue: _readUntil) DateTime? get validTill;/// The retention horizon (default ~10 years), not the booking window.
@AtgDateConverter() DateTime? get rememberTill;@AtgDateConverter()@JsonKey(readValue: _readCreated) DateTime? get createdAt; String? get validFromDateText; String? get validTillDateText;@JsonKey(readValue: _readStatus) String? get status;@JsonKey(readValue: _readDeleted) bool? get deleted;@JsonKey(readValue: _readCode) String? get code;@JsonKey(readValue: _readLink) String? get link;
/// Create a copy of AtgVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AtgVisitorDTOCopyWith<AtgVisitorDTO> get copyWith => _$AtgVisitorDTOCopyWithImpl<AtgVisitorDTO>(this as AtgVisitorDTO, _$identity);

  /// Serializes this AtgVisitorDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AtgVisitorDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validTill, validTill) || other.validTill == validTill)&&(identical(other.rememberTill, rememberTill) || other.rememberTill == rememberTill)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.validFromDateText, validFromDateText) || other.validFromDateText == validFromDateText)&&(identical(other.validTillDateText, validTillDateText) || other.validTillDateText == validTillDateText)&&(identical(other.status, status) || other.status == status)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.code, code) || other.code == code)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,firstName,lastName,phone,vehicleReg,validFrom,validTill,rememberTill,createdAt,validFromDateText,validTillDateText,status,deleted,code,link);

@override
String toString() {
  return 'AtgVisitorDTO(id: $id, fullName: $fullName, firstName: $firstName, lastName: $lastName, phone: $phone, vehicleReg: $vehicleReg, validFrom: $validFrom, validTill: $validTill, rememberTill: $rememberTill, createdAt: $createdAt, validFromDateText: $validFromDateText, validTillDateText: $validTillDateText, status: $status, deleted: $deleted, code: $code, link: $link)';
}


}

/// @nodoc
abstract mixin class $AtgVisitorDTOCopyWith<$Res>  {
  factory $AtgVisitorDTOCopyWith(AtgVisitorDTO value, $Res Function(AtgVisitorDTO) _then) = _$AtgVisitorDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readId) String? id,@JsonKey(readValue: _readFullName) String? fullName,@JsonKey(readValue: _readFirstName) String? firstName,@JsonKey(readValue: _readLastName) String? lastName,@JsonKey(readValue: _readPhone) String? phone,@JsonKey(readValue: _readVehicle) String? vehicleReg,@AtgDateConverter()@JsonKey(readValue: _readFrom) DateTime? validFrom,@AtgDateConverter()@JsonKey(readValue: _readUntil) DateTime? validTill,@AtgDateConverter() DateTime? rememberTill,@AtgDateConverter()@JsonKey(readValue: _readCreated) DateTime? createdAt, String? validFromDateText, String? validTillDateText,@JsonKey(readValue: _readStatus) String? status,@JsonKey(readValue: _readDeleted) bool? deleted,@JsonKey(readValue: _readCode) String? code,@JsonKey(readValue: _readLink) String? link
});




}
/// @nodoc
class _$AtgVisitorDTOCopyWithImpl<$Res>
    implements $AtgVisitorDTOCopyWith<$Res> {
  _$AtgVisitorDTOCopyWithImpl(this._self, this._then);

  final AtgVisitorDTO _self;
  final $Res Function(AtgVisitorDTO) _then;

/// Create a copy of AtgVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? phone = freezed,Object? vehicleReg = freezed,Object? validFrom = freezed,Object? validTill = freezed,Object? rememberTill = freezed,Object? createdAt = freezed,Object? validFromDateText = freezed,Object? validTillDateText = freezed,Object? status = freezed,Object? deleted = freezed,Object? code = freezed,Object? link = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,vehicleReg: freezed == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String?,validFrom: freezed == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,validTill: freezed == validTill ? _self.validTill : validTill // ignore: cast_nullable_to_non_nullable
as DateTime?,rememberTill: freezed == rememberTill ? _self.rememberTill : rememberTill // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,validFromDateText: freezed == validFromDateText ? _self.validFromDateText : validFromDateText // ignore: cast_nullable_to_non_nullable
as String?,validTillDateText: freezed == validTillDateText ? _self.validTillDateText : validTillDateText // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AtgVisitorDTO].
extension AtgVisitorDTOPatterns on AtgVisitorDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AtgVisitorDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AtgVisitorDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AtgVisitorDTO value)  $default,){
final _that = this;
switch (_that) {
case _AtgVisitorDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AtgVisitorDTO value)?  $default,){
final _that = this;
switch (_that) {
case _AtgVisitorDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String? id, @JsonKey(readValue: _readFullName)  String? fullName, @JsonKey(readValue: _readFirstName)  String? firstName, @JsonKey(readValue: _readLastName)  String? lastName, @JsonKey(readValue: _readPhone)  String? phone, @JsonKey(readValue: _readVehicle)  String? vehicleReg, @AtgDateConverter()@JsonKey(readValue: _readFrom)  DateTime? validFrom, @AtgDateConverter()@JsonKey(readValue: _readUntil)  DateTime? validTill, @AtgDateConverter()  DateTime? rememberTill, @AtgDateConverter()@JsonKey(readValue: _readCreated)  DateTime? createdAt,  String? validFromDateText,  String? validTillDateText, @JsonKey(readValue: _readStatus)  String? status, @JsonKey(readValue: _readDeleted)  bool? deleted, @JsonKey(readValue: _readCode)  String? code, @JsonKey(readValue: _readLink)  String? link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AtgVisitorDTO() when $default != null:
return $default(_that.id,_that.fullName,_that.firstName,_that.lastName,_that.phone,_that.vehicleReg,_that.validFrom,_that.validTill,_that.rememberTill,_that.createdAt,_that.validFromDateText,_that.validTillDateText,_that.status,_that.deleted,_that.code,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String? id, @JsonKey(readValue: _readFullName)  String? fullName, @JsonKey(readValue: _readFirstName)  String? firstName, @JsonKey(readValue: _readLastName)  String? lastName, @JsonKey(readValue: _readPhone)  String? phone, @JsonKey(readValue: _readVehicle)  String? vehicleReg, @AtgDateConverter()@JsonKey(readValue: _readFrom)  DateTime? validFrom, @AtgDateConverter()@JsonKey(readValue: _readUntil)  DateTime? validTill, @AtgDateConverter()  DateTime? rememberTill, @AtgDateConverter()@JsonKey(readValue: _readCreated)  DateTime? createdAt,  String? validFromDateText,  String? validTillDateText, @JsonKey(readValue: _readStatus)  String? status, @JsonKey(readValue: _readDeleted)  bool? deleted, @JsonKey(readValue: _readCode)  String? code, @JsonKey(readValue: _readLink)  String? link)  $default,) {final _that = this;
switch (_that) {
case _AtgVisitorDTO():
return $default(_that.id,_that.fullName,_that.firstName,_that.lastName,_that.phone,_that.vehicleReg,_that.validFrom,_that.validTill,_that.rememberTill,_that.createdAt,_that.validFromDateText,_that.validTillDateText,_that.status,_that.deleted,_that.code,_that.link);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readId)  String? id, @JsonKey(readValue: _readFullName)  String? fullName, @JsonKey(readValue: _readFirstName)  String? firstName, @JsonKey(readValue: _readLastName)  String? lastName, @JsonKey(readValue: _readPhone)  String? phone, @JsonKey(readValue: _readVehicle)  String? vehicleReg, @AtgDateConverter()@JsonKey(readValue: _readFrom)  DateTime? validFrom, @AtgDateConverter()@JsonKey(readValue: _readUntil)  DateTime? validTill, @AtgDateConverter()  DateTime? rememberTill, @AtgDateConverter()@JsonKey(readValue: _readCreated)  DateTime? createdAt,  String? validFromDateText,  String? validTillDateText, @JsonKey(readValue: _readStatus)  String? status, @JsonKey(readValue: _readDeleted)  bool? deleted, @JsonKey(readValue: _readCode)  String? code, @JsonKey(readValue: _readLink)  String? link)?  $default,) {final _that = this;
switch (_that) {
case _AtgVisitorDTO() when $default != null:
return $default(_that.id,_that.fullName,_that.firstName,_that.lastName,_that.phone,_that.vehicleReg,_that.validFrom,_that.validTill,_that.rememberTill,_that.createdAt,_that.validFromDateText,_that.validTillDateText,_that.status,_that.deleted,_that.code,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AtgVisitorDTO extends AtgVisitorDTO {
  const _AtgVisitorDTO({@JsonKey(readValue: _readId) this.id, @JsonKey(readValue: _readFullName) this.fullName, @JsonKey(readValue: _readFirstName) this.firstName, @JsonKey(readValue: _readLastName) this.lastName, @JsonKey(readValue: _readPhone) this.phone, @JsonKey(readValue: _readVehicle) this.vehicleReg, @AtgDateConverter()@JsonKey(readValue: _readFrom) this.validFrom, @AtgDateConverter()@JsonKey(readValue: _readUntil) this.validTill, @AtgDateConverter() this.rememberTill, @AtgDateConverter()@JsonKey(readValue: _readCreated) this.createdAt, this.validFromDateText, this.validTillDateText, @JsonKey(readValue: _readStatus) this.status, @JsonKey(readValue: _readDeleted) this.deleted, @JsonKey(readValue: _readCode) this.code, @JsonKey(readValue: _readLink) this.link}): super._();
  factory _AtgVisitorDTO.fromJson(Map<String, dynamic> json) => _$AtgVisitorDTOFromJson(json);

/// The per-invite record id. `uid` is the estate host uid shared by
/// every visitor record, so it is the last resort.
@override@JsonKey(readValue: _readId) final  String? id;
@override@JsonKey(readValue: _readFullName) final  String? fullName;
@override@JsonKey(readValue: _readFirstName) final  String? firstName;
@override@JsonKey(readValue: _readLastName) final  String? lastName;
@override@JsonKey(readValue: _readPhone) final  String? phone;
@override@JsonKey(readValue: _readVehicle) final  String? vehicleReg;
@override@AtgDateConverter()@JsonKey(readValue: _readFrom) final  DateTime? validFrom;
@override@AtgDateConverter()@JsonKey(readValue: _readUntil) final  DateTime? validTill;
/// The retention horizon (default ~10 years), not the booking window.
@override@AtgDateConverter() final  DateTime? rememberTill;
@override@AtgDateConverter()@JsonKey(readValue: _readCreated) final  DateTime? createdAt;
@override final  String? validFromDateText;
@override final  String? validTillDateText;
@override@JsonKey(readValue: _readStatus) final  String? status;
@override@JsonKey(readValue: _readDeleted) final  bool? deleted;
@override@JsonKey(readValue: _readCode) final  String? code;
@override@JsonKey(readValue: _readLink) final  String? link;

/// Create a copy of AtgVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AtgVisitorDTOCopyWith<_AtgVisitorDTO> get copyWith => __$AtgVisitorDTOCopyWithImpl<_AtgVisitorDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AtgVisitorDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AtgVisitorDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validTill, validTill) || other.validTill == validTill)&&(identical(other.rememberTill, rememberTill) || other.rememberTill == rememberTill)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.validFromDateText, validFromDateText) || other.validFromDateText == validFromDateText)&&(identical(other.validTillDateText, validTillDateText) || other.validTillDateText == validTillDateText)&&(identical(other.status, status) || other.status == status)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.code, code) || other.code == code)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,firstName,lastName,phone,vehicleReg,validFrom,validTill,rememberTill,createdAt,validFromDateText,validTillDateText,status,deleted,code,link);

@override
String toString() {
  return 'AtgVisitorDTO(id: $id, fullName: $fullName, firstName: $firstName, lastName: $lastName, phone: $phone, vehicleReg: $vehicleReg, validFrom: $validFrom, validTill: $validTill, rememberTill: $rememberTill, createdAt: $createdAt, validFromDateText: $validFromDateText, validTillDateText: $validTillDateText, status: $status, deleted: $deleted, code: $code, link: $link)';
}


}

/// @nodoc
abstract mixin class _$AtgVisitorDTOCopyWith<$Res> implements $AtgVisitorDTOCopyWith<$Res> {
  factory _$AtgVisitorDTOCopyWith(_AtgVisitorDTO value, $Res Function(_AtgVisitorDTO) _then) = __$AtgVisitorDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readId) String? id,@JsonKey(readValue: _readFullName) String? fullName,@JsonKey(readValue: _readFirstName) String? firstName,@JsonKey(readValue: _readLastName) String? lastName,@JsonKey(readValue: _readPhone) String? phone,@JsonKey(readValue: _readVehicle) String? vehicleReg,@AtgDateConverter()@JsonKey(readValue: _readFrom) DateTime? validFrom,@AtgDateConverter()@JsonKey(readValue: _readUntil) DateTime? validTill,@AtgDateConverter() DateTime? rememberTill,@AtgDateConverter()@JsonKey(readValue: _readCreated) DateTime? createdAt, String? validFromDateText, String? validTillDateText,@JsonKey(readValue: _readStatus) String? status,@JsonKey(readValue: _readDeleted) bool? deleted,@JsonKey(readValue: _readCode) String? code,@JsonKey(readValue: _readLink) String? link
});




}
/// @nodoc
class __$AtgVisitorDTOCopyWithImpl<$Res>
    implements _$AtgVisitorDTOCopyWith<$Res> {
  __$AtgVisitorDTOCopyWithImpl(this._self, this._then);

  final _AtgVisitorDTO _self;
  final $Res Function(_AtgVisitorDTO) _then;

/// Create a copy of AtgVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? phone = freezed,Object? vehicleReg = freezed,Object? validFrom = freezed,Object? validTill = freezed,Object? rememberTill = freezed,Object? createdAt = freezed,Object? validFromDateText = freezed,Object? validTillDateText = freezed,Object? status = freezed,Object? deleted = freezed,Object? code = freezed,Object? link = freezed,}) {
  return _then(_AtgVisitorDTO(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,vehicleReg: freezed == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String?,validFrom: freezed == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,validTill: freezed == validTill ? _self.validTill : validTill // ignore: cast_nullable_to_non_nullable
as DateTime?,rememberTill: freezed == rememberTill ? _self.rememberTill : rememberTill // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,validFromDateText: freezed == validFromDateText ? _self.validFromDateText : validFromDateText // ignore: cast_nullable_to_non_nullable
as String?,validTillDateText: freezed == validTillDateText ? _self.validTillDateText : validTillDateText // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
