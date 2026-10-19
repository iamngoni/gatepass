// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_visitor_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateVisitorDTO {

 String? get uid; String get name;/// Epoch milliseconds, UTC.
 int get validFrom; int get validTill; String? get surname; String? get phoneNumber; String? get carLic; int? get categoryId; int get visitsAllowed; String get notifyOn;
/// Create a copy of CreateVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVisitorDTOCopyWith<CreateVisitorDTO> get copyWith => _$CreateVisitorDTOCopyWithImpl<CreateVisitorDTO>(this as CreateVisitorDTO, _$identity);

  /// Serializes this CreateVisitorDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVisitorDTO&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validTill, validTill) || other.validTill == validTill)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.carLic, carLic) || other.carLic == carLic)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.visitsAllowed, visitsAllowed) || other.visitsAllowed == visitsAllowed)&&(identical(other.notifyOn, notifyOn) || other.notifyOn == notifyOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,name,validFrom,validTill,surname,phoneNumber,carLic,categoryId,visitsAllowed,notifyOn);

@override
String toString() {
  return 'CreateVisitorDTO(uid: $uid, name: $name, validFrom: $validFrom, validTill: $validTill, surname: $surname, phoneNumber: $phoneNumber, carLic: $carLic, categoryId: $categoryId, visitsAllowed: $visitsAllowed, notifyOn: $notifyOn)';
}


}

/// @nodoc
abstract mixin class $CreateVisitorDTOCopyWith<$Res>  {
  factory $CreateVisitorDTOCopyWith(CreateVisitorDTO value, $Res Function(CreateVisitorDTO) _then) = _$CreateVisitorDTOCopyWithImpl;
@useResult
$Res call({
 String? uid, String name, int validFrom, int validTill, String? surname, String? phoneNumber, String? carLic, int? categoryId, int visitsAllowed, String notifyOn
});




}
/// @nodoc
class _$CreateVisitorDTOCopyWithImpl<$Res>
    implements $CreateVisitorDTOCopyWith<$Res> {
  _$CreateVisitorDTOCopyWithImpl(this._self, this._then);

  final CreateVisitorDTO _self;
  final $Res Function(CreateVisitorDTO) _then;

/// Create a copy of CreateVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = freezed,Object? name = null,Object? validFrom = null,Object? validTill = null,Object? surname = freezed,Object? phoneNumber = freezed,Object? carLic = freezed,Object? categoryId = freezed,Object? visitsAllowed = null,Object? notifyOn = null,}) {
  return _then(_self.copyWith(
uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,validFrom: null == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as int,validTill: null == validTill ? _self.validTill : validTill // ignore: cast_nullable_to_non_nullable
as int,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,carLic: freezed == carLic ? _self.carLic : carLic // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,visitsAllowed: null == visitsAllowed ? _self.visitsAllowed : visitsAllowed // ignore: cast_nullable_to_non_nullable
as int,notifyOn: null == notifyOn ? _self.notifyOn : notifyOn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateVisitorDTO].
extension CreateVisitorDTOPatterns on CreateVisitorDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVisitorDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVisitorDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVisitorDTO value)  $default,){
final _that = this;
switch (_that) {
case _CreateVisitorDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVisitorDTO value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVisitorDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? uid,  String name,  int validFrom,  int validTill,  String? surname,  String? phoneNumber,  String? carLic,  int? categoryId,  int visitsAllowed,  String notifyOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVisitorDTO() when $default != null:
return $default(_that.uid,_that.name,_that.validFrom,_that.validTill,_that.surname,_that.phoneNumber,_that.carLic,_that.categoryId,_that.visitsAllowed,_that.notifyOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? uid,  String name,  int validFrom,  int validTill,  String? surname,  String? phoneNumber,  String? carLic,  int? categoryId,  int visitsAllowed,  String notifyOn)  $default,) {final _that = this;
switch (_that) {
case _CreateVisitorDTO():
return $default(_that.uid,_that.name,_that.validFrom,_that.validTill,_that.surname,_that.phoneNumber,_that.carLic,_that.categoryId,_that.visitsAllowed,_that.notifyOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? uid,  String name,  int validFrom,  int validTill,  String? surname,  String? phoneNumber,  String? carLic,  int? categoryId,  int visitsAllowed,  String notifyOn)?  $default,) {final _that = this;
switch (_that) {
case _CreateVisitorDTO() when $default != null:
return $default(_that.uid,_that.name,_that.validFrom,_that.validTill,_that.surname,_that.phoneNumber,_that.carLic,_that.categoryId,_that.visitsAllowed,_that.notifyOn);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CreateVisitorDTO implements CreateVisitorDTO {
  const _CreateVisitorDTO({required this.uid, required this.name, required this.validFrom, required this.validTill, this.surname, this.phoneNumber, this.carLic, this.categoryId, this.visitsAllowed = 1, this.notifyOn = 'both'});
  factory _CreateVisitorDTO.fromJson(Map<String, dynamic> json) => _$CreateVisitorDTOFromJson(json);

@override final  String? uid;
@override final  String name;
/// Epoch milliseconds, UTC.
@override final  int validFrom;
@override final  int validTill;
@override final  String? surname;
@override final  String? phoneNumber;
@override final  String? carLic;
@override final  int? categoryId;
@override@JsonKey() final  int visitsAllowed;
@override@JsonKey() final  String notifyOn;

/// Create a copy of CreateVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVisitorDTOCopyWith<_CreateVisitorDTO> get copyWith => __$CreateVisitorDTOCopyWithImpl<_CreateVisitorDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateVisitorDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVisitorDTO&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validTill, validTill) || other.validTill == validTill)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.carLic, carLic) || other.carLic == carLic)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.visitsAllowed, visitsAllowed) || other.visitsAllowed == visitsAllowed)&&(identical(other.notifyOn, notifyOn) || other.notifyOn == notifyOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,name,validFrom,validTill,surname,phoneNumber,carLic,categoryId,visitsAllowed,notifyOn);

@override
String toString() {
  return 'CreateVisitorDTO(uid: $uid, name: $name, validFrom: $validFrom, validTill: $validTill, surname: $surname, phoneNumber: $phoneNumber, carLic: $carLic, categoryId: $categoryId, visitsAllowed: $visitsAllowed, notifyOn: $notifyOn)';
}


}

/// @nodoc
abstract mixin class _$CreateVisitorDTOCopyWith<$Res> implements $CreateVisitorDTOCopyWith<$Res> {
  factory _$CreateVisitorDTOCopyWith(_CreateVisitorDTO value, $Res Function(_CreateVisitorDTO) _then) = __$CreateVisitorDTOCopyWithImpl;
@override @useResult
$Res call({
 String? uid, String name, int validFrom, int validTill, String? surname, String? phoneNumber, String? carLic, int? categoryId, int visitsAllowed, String notifyOn
});




}
/// @nodoc
class __$CreateVisitorDTOCopyWithImpl<$Res>
    implements _$CreateVisitorDTOCopyWith<$Res> {
  __$CreateVisitorDTOCopyWithImpl(this._self, this._then);

  final _CreateVisitorDTO _self;
  final $Res Function(_CreateVisitorDTO) _then;

/// Create a copy of CreateVisitorDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = freezed,Object? name = null,Object? validFrom = null,Object? validTill = null,Object? surname = freezed,Object? phoneNumber = freezed,Object? carLic = freezed,Object? categoryId = freezed,Object? visitsAllowed = null,Object? notifyOn = null,}) {
  return _then(_CreateVisitorDTO(
uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,validFrom: null == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as int,validTill: null == validTill ? _self.validTill : validTill // ignore: cast_nullable_to_non_nullable
as int,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,carLic: freezed == carLic ? _self.carLic : carLic // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,visitsAllowed: null == visitsAllowed ? _self.visitsAllowed : visitsAllowed // ignore: cast_nullable_to_non_nullable
as int,notifyOn: null == notifyOn ? _self.notifyOn : notifyOn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
