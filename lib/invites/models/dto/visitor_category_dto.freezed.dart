// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_category_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisitorCategoryDTO {

@JsonKey(readValue: _readId) int? get id;@JsonKey(readValue: _readName) String? get name;
/// Create a copy of VisitorCategoryDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitorCategoryDTOCopyWith<VisitorCategoryDTO> get copyWith => _$VisitorCategoryDTOCopyWithImpl<VisitorCategoryDTO>(this as VisitorCategoryDTO, _$identity);

  /// Serializes this VisitorCategoryDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitorCategoryDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'VisitorCategoryDTO(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $VisitorCategoryDTOCopyWith<$Res>  {
  factory $VisitorCategoryDTOCopyWith(VisitorCategoryDTO value, $Res Function(VisitorCategoryDTO) _then) = _$VisitorCategoryDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readId) int? id,@JsonKey(readValue: _readName) String? name
});




}
/// @nodoc
class _$VisitorCategoryDTOCopyWithImpl<$Res>
    implements $VisitorCategoryDTOCopyWith<$Res> {
  _$VisitorCategoryDTOCopyWithImpl(this._self, this._then);

  final VisitorCategoryDTO _self;
  final $Res Function(VisitorCategoryDTO) _then;

/// Create a copy of VisitorCategoryDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisitorCategoryDTO].
extension VisitorCategoryDTOPatterns on VisitorCategoryDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisitorCategoryDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisitorCategoryDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisitorCategoryDTO value)  $default,){
final _that = this;
switch (_that) {
case _VisitorCategoryDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisitorCategoryDTO value)?  $default,){
final _that = this;
switch (_that) {
case _VisitorCategoryDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  int? id, @JsonKey(readValue: _readName)  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisitorCategoryDTO() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  int? id, @JsonKey(readValue: _readName)  String? name)  $default,) {final _that = this;
switch (_that) {
case _VisitorCategoryDTO():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readId)  int? id, @JsonKey(readValue: _readName)  String? name)?  $default,) {final _that = this;
switch (_that) {
case _VisitorCategoryDTO() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisitorCategoryDTO extends VisitorCategoryDTO {
  const _VisitorCategoryDTO({@JsonKey(readValue: _readId) this.id, @JsonKey(readValue: _readName) this.name}): super._();
  factory _VisitorCategoryDTO.fromJson(Map<String, dynamic> json) => _$VisitorCategoryDTOFromJson(json);

@override@JsonKey(readValue: _readId) final  int? id;
@override@JsonKey(readValue: _readName) final  String? name;

/// Create a copy of VisitorCategoryDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitorCategoryDTOCopyWith<_VisitorCategoryDTO> get copyWith => __$VisitorCategoryDTOCopyWithImpl<_VisitorCategoryDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisitorCategoryDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisitorCategoryDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'VisitorCategoryDTO(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$VisitorCategoryDTOCopyWith<$Res> implements $VisitorCategoryDTOCopyWith<$Res> {
  factory _$VisitorCategoryDTOCopyWith(_VisitorCategoryDTO value, $Res Function(_VisitorCategoryDTO) _then) = __$VisitorCategoryDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readId) int? id,@JsonKey(readValue: _readName) String? name
});




}
/// @nodoc
class __$VisitorCategoryDTOCopyWithImpl<$Res>
    implements _$VisitorCategoryDTOCopyWith<$Res> {
  __$VisitorCategoryDTOCopyWithImpl(this._self, this._then);

  final _VisitorCategoryDTO _self;
  final $Res Function(_VisitorCategoryDTO) _then;

/// Create a copy of VisitorCategoryDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_VisitorCategoryDTO(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
