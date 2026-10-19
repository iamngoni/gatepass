// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appearance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppearanceEvent {

 Appearance get appearance;
/// Create a copy of AppearanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppearanceEventCopyWith<AppearanceEvent> get copyWith => _$AppearanceEventCopyWithImpl<AppearanceEvent>(this as AppearanceEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearanceEvent&&(identical(other.appearance, appearance) || other.appearance == appearance));
}


@override
int get hashCode => Object.hash(runtimeType,appearance);

@override
String toString() {
  return 'AppearanceEvent(appearance: $appearance)';
}


}

/// @nodoc
abstract mixin class $AppearanceEventCopyWith<$Res>  {
  factory $AppearanceEventCopyWith(AppearanceEvent value, $Res Function(AppearanceEvent) _then) = _$AppearanceEventCopyWithImpl;
@useResult
$Res call({
 Appearance appearance
});




}
/// @nodoc
class _$AppearanceEventCopyWithImpl<$Res>
    implements $AppearanceEventCopyWith<$Res> {
  _$AppearanceEventCopyWithImpl(this._self, this._then);

  final AppearanceEvent _self;
  final $Res Function(AppearanceEvent) _then;

/// Create a copy of AppearanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appearance = null,}) {
  return _then(_self.copyWith(
appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as Appearance,
  ));
}

}


/// Adds pattern-matching-related methods to [AppearanceEvent].
extension AppearanceEventPatterns on AppearanceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppearanceChangedEvent value)?  changed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppearanceChangedEvent() when changed != null:
return changed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppearanceChangedEvent value)  changed,}){
final _that = this;
switch (_that) {
case AppearanceChangedEvent():
return changed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppearanceChangedEvent value)?  changed,}){
final _that = this;
switch (_that) {
case AppearanceChangedEvent() when changed != null:
return changed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Appearance appearance)?  changed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppearanceChangedEvent() when changed != null:
return changed(_that.appearance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Appearance appearance)  changed,}) {final _that = this;
switch (_that) {
case AppearanceChangedEvent():
return changed(_that.appearance);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Appearance appearance)?  changed,}) {final _that = this;
switch (_that) {
case AppearanceChangedEvent() when changed != null:
return changed(_that.appearance);case _:
  return null;

}
}

}

/// @nodoc


class AppearanceChangedEvent implements AppearanceEvent {
  const AppearanceChangedEvent({required this.appearance});
  

@override final  Appearance appearance;

/// Create a copy of AppearanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppearanceChangedEventCopyWith<AppearanceChangedEvent> get copyWith => _$AppearanceChangedEventCopyWithImpl<AppearanceChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearanceChangedEvent&&(identical(other.appearance, appearance) || other.appearance == appearance));
}


@override
int get hashCode => Object.hash(runtimeType,appearance);

@override
String toString() {
  return 'AppearanceEvent.changed(appearance: $appearance)';
}


}

/// @nodoc
abstract mixin class $AppearanceChangedEventCopyWith<$Res> implements $AppearanceEventCopyWith<$Res> {
  factory $AppearanceChangedEventCopyWith(AppearanceChangedEvent value, $Res Function(AppearanceChangedEvent) _then) = _$AppearanceChangedEventCopyWithImpl;
@override @useResult
$Res call({
 Appearance appearance
});




}
/// @nodoc
class _$AppearanceChangedEventCopyWithImpl<$Res>
    implements $AppearanceChangedEventCopyWith<$Res> {
  _$AppearanceChangedEventCopyWithImpl(this._self, this._then);

  final AppearanceChangedEvent _self;
  final $Res Function(AppearanceChangedEvent) _then;

/// Create a copy of AppearanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appearance = null,}) {
  return _then(AppearanceChangedEvent(
appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as Appearance,
  ));
}


}

/// @nodoc
mixin _$AppearanceState {

 Appearance get appearance;
/// Create a copy of AppearanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppearanceStateCopyWith<AppearanceState> get copyWith => _$AppearanceStateCopyWithImpl<AppearanceState>(this as AppearanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearanceState&&(identical(other.appearance, appearance) || other.appearance == appearance));
}


@override
int get hashCode => Object.hash(runtimeType,appearance);

@override
String toString() {
  return 'AppearanceState(appearance: $appearance)';
}


}

/// @nodoc
abstract mixin class $AppearanceStateCopyWith<$Res>  {
  factory $AppearanceStateCopyWith(AppearanceState value, $Res Function(AppearanceState) _then) = _$AppearanceStateCopyWithImpl;
@useResult
$Res call({
 Appearance appearance
});




}
/// @nodoc
class _$AppearanceStateCopyWithImpl<$Res>
    implements $AppearanceStateCopyWith<$Res> {
  _$AppearanceStateCopyWithImpl(this._self, this._then);

  final AppearanceState _self;
  final $Res Function(AppearanceState) _then;

/// Create a copy of AppearanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appearance = null,}) {
  return _then(_self.copyWith(
appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as Appearance,
  ));
}

}


/// Adds pattern-matching-related methods to [AppearanceState].
extension AppearanceStatePatterns on AppearanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppearanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppearanceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppearanceState value)  $default,){
final _that = this;
switch (_that) {
case _AppearanceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppearanceState value)?  $default,){
final _that = this;
switch (_that) {
case _AppearanceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Appearance appearance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppearanceState() when $default != null:
return $default(_that.appearance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Appearance appearance)  $default,) {final _that = this;
switch (_that) {
case _AppearanceState():
return $default(_that.appearance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Appearance appearance)?  $default,) {final _that = this;
switch (_that) {
case _AppearanceState() when $default != null:
return $default(_that.appearance);case _:
  return null;

}
}

}

/// @nodoc


class _AppearanceState implements AppearanceState {
  const _AppearanceState({this.appearance = Appearance.system});
  

@override@JsonKey() final  Appearance appearance;

/// Create a copy of AppearanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppearanceStateCopyWith<_AppearanceState> get copyWith => __$AppearanceStateCopyWithImpl<_AppearanceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppearanceState&&(identical(other.appearance, appearance) || other.appearance == appearance));
}


@override
int get hashCode => Object.hash(runtimeType,appearance);

@override
String toString() {
  return 'AppearanceState(appearance: $appearance)';
}


}

/// @nodoc
abstract mixin class _$AppearanceStateCopyWith<$Res> implements $AppearanceStateCopyWith<$Res> {
  factory _$AppearanceStateCopyWith(_AppearanceState value, $Res Function(_AppearanceState) _then) = __$AppearanceStateCopyWithImpl;
@override @useResult
$Res call({
 Appearance appearance
});




}
/// @nodoc
class __$AppearanceStateCopyWithImpl<$Res>
    implements _$AppearanceStateCopyWith<$Res> {
  __$AppearanceStateCopyWithImpl(this._self, this._then);

  final _AppearanceState _self;
  final $Res Function(_AppearanceState) _then;

/// Create a copy of AppearanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appearance = null,}) {
  return _then(_AppearanceState(
appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as Appearance,
  ));
}


}

// dart format on
