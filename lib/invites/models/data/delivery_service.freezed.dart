// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryService {

 String get id; String get name; ServiceKind get kind; Duration get window; String get iconAsset;/// A shorter label for a quick tile, when [name] doesn't fit.
 String? get tileName;
/// Create a copy of DeliveryService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryServiceCopyWith<DeliveryService> get copyWith => _$DeliveryServiceCopyWithImpl<DeliveryService>(this as DeliveryService, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.window, window) || other.window == window)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset)&&(identical(other.tileName, tileName) || other.tileName == tileName));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,kind,window,iconAsset,tileName);

@override
String toString() {
  return 'DeliveryService(id: $id, name: $name, kind: $kind, window: $window, iconAsset: $iconAsset, tileName: $tileName)';
}


}

/// @nodoc
abstract mixin class $DeliveryServiceCopyWith<$Res>  {
  factory $DeliveryServiceCopyWith(DeliveryService value, $Res Function(DeliveryService) _then) = _$DeliveryServiceCopyWithImpl;
@useResult
$Res call({
 String id, String name, ServiceKind kind, Duration window, String iconAsset, String? tileName
});




}
/// @nodoc
class _$DeliveryServiceCopyWithImpl<$Res>
    implements $DeliveryServiceCopyWith<$Res> {
  _$DeliveryServiceCopyWithImpl(this._self, this._then);

  final DeliveryService _self;
  final $Res Function(DeliveryService) _then;

/// Create a copy of DeliveryService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? window = null,Object? iconAsset = null,Object? tileName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ServiceKind,window: null == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as Duration,iconAsset: null == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as String,tileName: freezed == tileName ? _self.tileName : tileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryService].
extension DeliveryServicePatterns on DeliveryService {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryService() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryService value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryService():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryService value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryService() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  ServiceKind kind,  Duration window,  String iconAsset,  String? tileName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryService() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.window,_that.iconAsset,_that.tileName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  ServiceKind kind,  Duration window,  String iconAsset,  String? tileName)  $default,) {final _that = this;
switch (_that) {
case _DeliveryService():
return $default(_that.id,_that.name,_that.kind,_that.window,_that.iconAsset,_that.tileName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  ServiceKind kind,  Duration window,  String iconAsset,  String? tileName)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryService() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.window,_that.iconAsset,_that.tileName);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryService extends DeliveryService {
  const _DeliveryService({required this.id, required this.name, required this.kind, required this.window, required this.iconAsset, this.tileName}): super._();
  

@override final  String id;
@override final  String name;
@override final  ServiceKind kind;
@override final  Duration window;
@override final  String iconAsset;
/// A shorter label for a quick tile, when [name] doesn't fit.
@override final  String? tileName;

/// Create a copy of DeliveryService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryServiceCopyWith<_DeliveryService> get copyWith => __$DeliveryServiceCopyWithImpl<_DeliveryService>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.window, window) || other.window == window)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset)&&(identical(other.tileName, tileName) || other.tileName == tileName));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,kind,window,iconAsset,tileName);

@override
String toString() {
  return 'DeliveryService(id: $id, name: $name, kind: $kind, window: $window, iconAsset: $iconAsset, tileName: $tileName)';
}


}

/// @nodoc
abstract mixin class _$DeliveryServiceCopyWith<$Res> implements $DeliveryServiceCopyWith<$Res> {
  factory _$DeliveryServiceCopyWith(_DeliveryService value, $Res Function(_DeliveryService) _then) = __$DeliveryServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, ServiceKind kind, Duration window, String iconAsset, String? tileName
});




}
/// @nodoc
class __$DeliveryServiceCopyWithImpl<$Res>
    implements _$DeliveryServiceCopyWith<$Res> {
  __$DeliveryServiceCopyWithImpl(this._self, this._then);

  final _DeliveryService _self;
  final $Res Function(_DeliveryService) _then;

/// Create a copy of DeliveryService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? window = null,Object? iconAsset = null,Object? tileName = freezed,}) {
  return _then(_DeliveryService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ServiceKind,window: null == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as Duration,iconAsset: null == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as String,tileName: freezed == tileName ? _self.tileName : tileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
