// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsEvent()';
}


}

/// @nodoc
class $NotificationsEventCopyWith<$Res>  {
$NotificationsEventCopyWith(NotificationsEvent _, $Res Function(NotificationsEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationsEvent].
extension NotificationsEventPatterns on NotificationsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationsStartedEvent value)?  started,TResult Function( NotificationsClearedEvent value)?  cleared,TResult Function( NotificationsRefreshRequestedEvent value)?  refreshRequested,TResult Function( NotificationsMarkReadRequestedEvent value)?  markReadRequested,TResult Function( NotificationsMarkAllReadRequestedEvent value)?  markAllReadRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationsStartedEvent() when started != null:
return started(_that);case NotificationsClearedEvent() when cleared != null:
return cleared(_that);case NotificationsRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested(_that);case NotificationsMarkReadRequestedEvent() when markReadRequested != null:
return markReadRequested(_that);case NotificationsMarkAllReadRequestedEvent() when markAllReadRequested != null:
return markAllReadRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationsStartedEvent value)  started,required TResult Function( NotificationsClearedEvent value)  cleared,required TResult Function( NotificationsRefreshRequestedEvent value)  refreshRequested,required TResult Function( NotificationsMarkReadRequestedEvent value)  markReadRequested,required TResult Function( NotificationsMarkAllReadRequestedEvent value)  markAllReadRequested,}){
final _that = this;
switch (_that) {
case NotificationsStartedEvent():
return started(_that);case NotificationsClearedEvent():
return cleared(_that);case NotificationsRefreshRequestedEvent():
return refreshRequested(_that);case NotificationsMarkReadRequestedEvent():
return markReadRequested(_that);case NotificationsMarkAllReadRequestedEvent():
return markAllReadRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationsStartedEvent value)?  started,TResult? Function( NotificationsClearedEvent value)?  cleared,TResult? Function( NotificationsRefreshRequestedEvent value)?  refreshRequested,TResult? Function( NotificationsMarkReadRequestedEvent value)?  markReadRequested,TResult? Function( NotificationsMarkAllReadRequestedEvent value)?  markAllReadRequested,}){
final _that = this;
switch (_that) {
case NotificationsStartedEvent() when started != null:
return started(_that);case NotificationsClearedEvent() when cleared != null:
return cleared(_that);case NotificationsRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested(_that);case NotificationsMarkReadRequestedEvent() when markReadRequested != null:
return markReadRequested(_that);case NotificationsMarkAllReadRequestedEvent() when markAllReadRequested != null:
return markAllReadRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String siteId)?  started,TResult Function()?  cleared,TResult Function()?  refreshRequested,TResult Function( List<String> ids)?  markReadRequested,TResult Function()?  markAllReadRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationsStartedEvent() when started != null:
return started(_that.siteId);case NotificationsClearedEvent() when cleared != null:
return cleared();case NotificationsRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested();case NotificationsMarkReadRequestedEvent() when markReadRequested != null:
return markReadRequested(_that.ids);case NotificationsMarkAllReadRequestedEvent() when markAllReadRequested != null:
return markAllReadRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String siteId)  started,required TResult Function()  cleared,required TResult Function()  refreshRequested,required TResult Function( List<String> ids)  markReadRequested,required TResult Function()  markAllReadRequested,}) {final _that = this;
switch (_that) {
case NotificationsStartedEvent():
return started(_that.siteId);case NotificationsClearedEvent():
return cleared();case NotificationsRefreshRequestedEvent():
return refreshRequested();case NotificationsMarkReadRequestedEvent():
return markReadRequested(_that.ids);case NotificationsMarkAllReadRequestedEvent():
return markAllReadRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String siteId)?  started,TResult? Function()?  cleared,TResult? Function()?  refreshRequested,TResult? Function( List<String> ids)?  markReadRequested,TResult? Function()?  markAllReadRequested,}) {final _that = this;
switch (_that) {
case NotificationsStartedEvent() when started != null:
return started(_that.siteId);case NotificationsClearedEvent() when cleared != null:
return cleared();case NotificationsRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested();case NotificationsMarkReadRequestedEvent() when markReadRequested != null:
return markReadRequested(_that.ids);case NotificationsMarkAllReadRequestedEvent() when markAllReadRequested != null:
return markAllReadRequested();case _:
  return null;

}
}

}

/// @nodoc


class NotificationsStartedEvent with DiagnosticableTreeMixin implements NotificationsEvent {
  const NotificationsStartedEvent({required this.siteId});
  

 final  String siteId;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsStartedEventCopyWith<NotificationsStartedEvent> get copyWith => _$NotificationsStartedEventCopyWithImpl<NotificationsStartedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsEvent.started'))
    ..add(DiagnosticsProperty('siteId', siteId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsStartedEvent&&(identical(other.siteId, siteId) || other.siteId == siteId));
}


@override
int get hashCode => Object.hash(runtimeType,siteId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsEvent.started(siteId: $siteId)';
}


}

/// @nodoc
abstract mixin class $NotificationsStartedEventCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory $NotificationsStartedEventCopyWith(NotificationsStartedEvent value, $Res Function(NotificationsStartedEvent) _then) = _$NotificationsStartedEventCopyWithImpl;
@useResult
$Res call({
 String siteId
});




}
/// @nodoc
class _$NotificationsStartedEventCopyWithImpl<$Res>
    implements $NotificationsStartedEventCopyWith<$Res> {
  _$NotificationsStartedEventCopyWithImpl(this._self, this._then);

  final NotificationsStartedEvent _self;
  final $Res Function(NotificationsStartedEvent) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? siteId = null,}) {
  return _then(NotificationsStartedEvent(
siteId: null == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotificationsClearedEvent with DiagnosticableTreeMixin implements NotificationsEvent {
  const NotificationsClearedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsEvent.cleared'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsClearedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsEvent.cleared()';
}


}




/// @nodoc


class NotificationsRefreshRequestedEvent with DiagnosticableTreeMixin implements NotificationsEvent {
  const NotificationsRefreshRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsEvent.refreshRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsRefreshRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsEvent.refreshRequested()';
}


}




/// @nodoc


class NotificationsMarkReadRequestedEvent with DiagnosticableTreeMixin implements NotificationsEvent {
  const NotificationsMarkReadRequestedEvent({required final  List<String> ids}): _ids = ids;
  

 final  List<String> _ids;
 List<String> get ids {
  if (_ids is EqualUnmodifiableListView) return _ids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ids);
}


/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsMarkReadRequestedEventCopyWith<NotificationsMarkReadRequestedEvent> get copyWith => _$NotificationsMarkReadRequestedEventCopyWithImpl<NotificationsMarkReadRequestedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsEvent.markReadRequested'))
    ..add(DiagnosticsProperty('ids', ids));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsMarkReadRequestedEvent&&const DeepCollectionEquality().equals(other._ids, _ids));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_ids));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsEvent.markReadRequested(ids: $ids)';
}


}

/// @nodoc
abstract mixin class $NotificationsMarkReadRequestedEventCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory $NotificationsMarkReadRequestedEventCopyWith(NotificationsMarkReadRequestedEvent value, $Res Function(NotificationsMarkReadRequestedEvent) _then) = _$NotificationsMarkReadRequestedEventCopyWithImpl;
@useResult
$Res call({
 List<String> ids
});




}
/// @nodoc
class _$NotificationsMarkReadRequestedEventCopyWithImpl<$Res>
    implements $NotificationsMarkReadRequestedEventCopyWith<$Res> {
  _$NotificationsMarkReadRequestedEventCopyWithImpl(this._self, this._then);

  final NotificationsMarkReadRequestedEvent _self;
  final $Res Function(NotificationsMarkReadRequestedEvent) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ids = null,}) {
  return _then(NotificationsMarkReadRequestedEvent(
ids: null == ids ? _self._ids : ids // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class NotificationsMarkAllReadRequestedEvent with DiagnosticableTreeMixin implements NotificationsEvent {
  const NotificationsMarkAllReadRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsEvent.markAllReadRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsMarkAllReadRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsEvent.markAllReadRequested()';
}


}




/// @nodoc
mixin _$NotificationsState implements DiagnosticableTreeMixin {

 String? get siteId; List<AppNotification> get notifications;/// The latest fetch from ATG.
 RequestStatus<Unit>? get refresh;
/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsStateCopyWith<NotificationsState> get copyWith => _$NotificationsStateCopyWithImpl<NotificationsState>(this as NotificationsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsState'))
    ..add(DiagnosticsProperty('siteId', siteId))..add(DiagnosticsProperty('notifications', notifications))..add(DiagnosticsProperty('refresh', refresh));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsState&&(identical(other.siteId, siteId) || other.siteId == siteId)&&const DeepCollectionEquality().equals(other.notifications, notifications)&&(identical(other.refresh, refresh) || other.refresh == refresh));
}


@override
int get hashCode => Object.hash(runtimeType,siteId,const DeepCollectionEquality().hash(notifications),refresh);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsState(siteId: $siteId, notifications: $notifications, refresh: $refresh)';
}


}

/// @nodoc
abstract mixin class $NotificationsStateCopyWith<$Res>  {
  factory $NotificationsStateCopyWith(NotificationsState value, $Res Function(NotificationsState) _then) = _$NotificationsStateCopyWithImpl;
@useResult
$Res call({
 String? siteId, List<AppNotification> notifications, RequestStatus<Unit>? refresh
});


$RequestStatusCopyWith<Unit, $Res>? get refresh;

}
/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._self, this._then);

  final NotificationsState _self;
  final $Res Function(NotificationsState) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? siteId = freezed,Object? notifications = null,Object? refresh = freezed,}) {
  return _then(_self.copyWith(
siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String?,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as RequestStatus<Unit>?,
  ));
}
/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestStatusCopyWith<Unit, $Res>? get refresh {
    if (_self.refresh == null) {
    return null;
  }

  return $RequestStatusCopyWith<Unit, $Res>(_self.refresh!, (value) {
    return _then(_self.copyWith(refresh: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationsState].
extension NotificationsStatePatterns on NotificationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? siteId,  List<AppNotification> notifications,  RequestStatus<Unit>? refresh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
return $default(_that.siteId,_that.notifications,_that.refresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? siteId,  List<AppNotification> notifications,  RequestStatus<Unit>? refresh)  $default,) {final _that = this;
switch (_that) {
case _NotificationsState():
return $default(_that.siteId,_that.notifications,_that.refresh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? siteId,  List<AppNotification> notifications,  RequestStatus<Unit>? refresh)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
return $default(_that.siteId,_that.notifications,_that.refresh);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationsState extends NotificationsState with DiagnosticableTreeMixin {
  const _NotificationsState({this.siteId, final  List<AppNotification> notifications = const [], this.refresh}): _notifications = notifications,super._();
  

@override final  String? siteId;
 final  List<AppNotification> _notifications;
@override@JsonKey() List<AppNotification> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

/// The latest fetch from ATG.
@override final  RequestStatus<Unit>? refresh;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsStateCopyWith<_NotificationsState> get copyWith => __$NotificationsStateCopyWithImpl<_NotificationsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationsState'))
    ..add(DiagnosticsProperty('siteId', siteId))..add(DiagnosticsProperty('notifications', notifications))..add(DiagnosticsProperty('refresh', refresh));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsState&&(identical(other.siteId, siteId) || other.siteId == siteId)&&const DeepCollectionEquality().equals(other._notifications, _notifications)&&(identical(other.refresh, refresh) || other.refresh == refresh));
}


@override
int get hashCode => Object.hash(runtimeType,siteId,const DeepCollectionEquality().hash(_notifications),refresh);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationsState(siteId: $siteId, notifications: $notifications, refresh: $refresh)';
}


}

/// @nodoc
abstract mixin class _$NotificationsStateCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory _$NotificationsStateCopyWith(_NotificationsState value, $Res Function(_NotificationsState) _then) = __$NotificationsStateCopyWithImpl;
@override @useResult
$Res call({
 String? siteId, List<AppNotification> notifications, RequestStatus<Unit>? refresh
});


@override $RequestStatusCopyWith<Unit, $Res>? get refresh;

}
/// @nodoc
class __$NotificationsStateCopyWithImpl<$Res>
    implements _$NotificationsStateCopyWith<$Res> {
  __$NotificationsStateCopyWithImpl(this._self, this._then);

  final _NotificationsState _self;
  final $Res Function(_NotificationsState) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? siteId = freezed,Object? notifications = null,Object? refresh = freezed,}) {
  return _then(_NotificationsState(
siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String?,notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as RequestStatus<Unit>?,
  ));
}

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestStatusCopyWith<Unit, $Res>? get refresh {
    if (_self.refresh == null) {
    return null;
  }

  return $RequestStatusCopyWith<Unit, $Res>(_self.refresh!, (value) {
    return _then(_self.copyWith(refresh: value));
  });
}
}

// dart format on
