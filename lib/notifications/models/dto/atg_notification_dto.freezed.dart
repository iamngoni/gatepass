// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atg_notification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AtgNotificationDTO {

@JsonKey(readValue: _readId) String? get id;@JsonKey(readValue: _readTitle) String? get title;@JsonKey(readValue: _readBody) String? get body;/// ATG's own spelling of "date added".
@AtgDateConverter()@JsonKey(readValue: _readTime) DateTime? get time;/// Kept raw for the fallback id, which earlier builds derived from it.
 Object? get dataAdded;@JsonKey(readValue: _readRead) bool? get read;
/// Create a copy of AtgNotificationDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AtgNotificationDTOCopyWith<AtgNotificationDTO> get copyWith => _$AtgNotificationDTOCopyWithImpl<AtgNotificationDTO>(this as AtgNotificationDTO, _$identity);

  /// Serializes this AtgNotificationDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AtgNotificationDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.dataAdded, dataAdded)&&(identical(other.read, read) || other.read == read));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,time,const DeepCollectionEquality().hash(dataAdded),read);

@override
String toString() {
  return 'AtgNotificationDTO(id: $id, title: $title, body: $body, time: $time, dataAdded: $dataAdded, read: $read)';
}


}

/// @nodoc
abstract mixin class $AtgNotificationDTOCopyWith<$Res>  {
  factory $AtgNotificationDTOCopyWith(AtgNotificationDTO value, $Res Function(AtgNotificationDTO) _then) = _$AtgNotificationDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readId) String? id,@JsonKey(readValue: _readTitle) String? title,@JsonKey(readValue: _readBody) String? body,@AtgDateConverter()@JsonKey(readValue: _readTime) DateTime? time, Object? dataAdded,@JsonKey(readValue: _readRead) bool? read
});




}
/// @nodoc
class _$AtgNotificationDTOCopyWithImpl<$Res>
    implements $AtgNotificationDTOCopyWith<$Res> {
  _$AtgNotificationDTOCopyWithImpl(this._self, this._then);

  final AtgNotificationDTO _self;
  final $Res Function(AtgNotificationDTO) _then;

/// Create a copy of AtgNotificationDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? body = freezed,Object? time = freezed,Object? dataAdded = freezed,Object? read = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,dataAdded: freezed == dataAdded ? _self.dataAdded : dataAdded ,read: freezed == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AtgNotificationDTO].
extension AtgNotificationDTOPatterns on AtgNotificationDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AtgNotificationDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AtgNotificationDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AtgNotificationDTO value)  $default,){
final _that = this;
switch (_that) {
case _AtgNotificationDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AtgNotificationDTO value)?  $default,){
final _that = this;
switch (_that) {
case _AtgNotificationDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String? id, @JsonKey(readValue: _readTitle)  String? title, @JsonKey(readValue: _readBody)  String? body, @AtgDateConverter()@JsonKey(readValue: _readTime)  DateTime? time,  Object? dataAdded, @JsonKey(readValue: _readRead)  bool? read)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AtgNotificationDTO() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.time,_that.dataAdded,_that.read);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String? id, @JsonKey(readValue: _readTitle)  String? title, @JsonKey(readValue: _readBody)  String? body, @AtgDateConverter()@JsonKey(readValue: _readTime)  DateTime? time,  Object? dataAdded, @JsonKey(readValue: _readRead)  bool? read)  $default,) {final _that = this;
switch (_that) {
case _AtgNotificationDTO():
return $default(_that.id,_that.title,_that.body,_that.time,_that.dataAdded,_that.read);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readId)  String? id, @JsonKey(readValue: _readTitle)  String? title, @JsonKey(readValue: _readBody)  String? body, @AtgDateConverter()@JsonKey(readValue: _readTime)  DateTime? time,  Object? dataAdded, @JsonKey(readValue: _readRead)  bool? read)?  $default,) {final _that = this;
switch (_that) {
case _AtgNotificationDTO() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.time,_that.dataAdded,_that.read);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AtgNotificationDTO extends AtgNotificationDTO {
  const _AtgNotificationDTO({@JsonKey(readValue: _readId) this.id, @JsonKey(readValue: _readTitle) this.title, @JsonKey(readValue: _readBody) this.body, @AtgDateConverter()@JsonKey(readValue: _readTime) this.time, this.dataAdded, @JsonKey(readValue: _readRead) this.read}): super._();
  factory _AtgNotificationDTO.fromJson(Map<String, dynamic> json) => _$AtgNotificationDTOFromJson(json);

@override@JsonKey(readValue: _readId) final  String? id;
@override@JsonKey(readValue: _readTitle) final  String? title;
@override@JsonKey(readValue: _readBody) final  String? body;
/// ATG's own spelling of "date added".
@override@AtgDateConverter()@JsonKey(readValue: _readTime) final  DateTime? time;
/// Kept raw for the fallback id, which earlier builds derived from it.
@override final  Object? dataAdded;
@override@JsonKey(readValue: _readRead) final  bool? read;

/// Create a copy of AtgNotificationDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AtgNotificationDTOCopyWith<_AtgNotificationDTO> get copyWith => __$AtgNotificationDTOCopyWithImpl<_AtgNotificationDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AtgNotificationDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AtgNotificationDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.dataAdded, dataAdded)&&(identical(other.read, read) || other.read == read));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,time,const DeepCollectionEquality().hash(dataAdded),read);

@override
String toString() {
  return 'AtgNotificationDTO(id: $id, title: $title, body: $body, time: $time, dataAdded: $dataAdded, read: $read)';
}


}

/// @nodoc
abstract mixin class _$AtgNotificationDTOCopyWith<$Res> implements $AtgNotificationDTOCopyWith<$Res> {
  factory _$AtgNotificationDTOCopyWith(_AtgNotificationDTO value, $Res Function(_AtgNotificationDTO) _then) = __$AtgNotificationDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readId) String? id,@JsonKey(readValue: _readTitle) String? title,@JsonKey(readValue: _readBody) String? body,@AtgDateConverter()@JsonKey(readValue: _readTime) DateTime? time, Object? dataAdded,@JsonKey(readValue: _readRead) bool? read
});




}
/// @nodoc
class __$AtgNotificationDTOCopyWithImpl<$Res>
    implements _$AtgNotificationDTOCopyWith<$Res> {
  __$AtgNotificationDTOCopyWithImpl(this._self, this._then);

  final _AtgNotificationDTO _self;
  final $Res Function(_AtgNotificationDTO) _then;

/// Create a copy of AtgNotificationDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? body = freezed,Object? time = freezed,Object? dataAdded = freezed,Object? read = freezed,}) {
  return _then(_AtgNotificationDTO(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,dataAdded: freezed == dataAdded ? _self.dataAdded : dataAdded ,read: freezed == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
