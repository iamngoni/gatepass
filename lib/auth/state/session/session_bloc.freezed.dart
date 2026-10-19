// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionEvent()';
}


}

/// @nodoc
class $SessionEventCopyWith<$Res>  {
$SessionEventCopyWith(SessionEvent _, $Res Function(SessionEvent) __);
}


/// Adds pattern-matching-related methods to [SessionEvent].
extension SessionEventPatterns on SessionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionStartedEvent value)?  started,TResult Function( SessionSignedInEvent value)?  signedIn,TResult Function( SessionSignOutRequestedEvent value)?  signOutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionStartedEvent() when started != null:
return started(_that);case SessionSignedInEvent() when signedIn != null:
return signedIn(_that);case SessionSignOutRequestedEvent() when signOutRequested != null:
return signOutRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionStartedEvent value)  started,required TResult Function( SessionSignedInEvent value)  signedIn,required TResult Function( SessionSignOutRequestedEvent value)  signOutRequested,}){
final _that = this;
switch (_that) {
case SessionStartedEvent():
return started(_that);case SessionSignedInEvent():
return signedIn(_that);case SessionSignOutRequestedEvent():
return signOutRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionStartedEvent value)?  started,TResult? Function( SessionSignedInEvent value)?  signedIn,TResult? Function( SessionSignOutRequestedEvent value)?  signOutRequested,}){
final _that = this;
switch (_that) {
case SessionStartedEvent() when started != null:
return started(_that);case SessionSignedInEvent() when signedIn != null:
return signedIn(_that);case SessionSignOutRequestedEvent() when signOutRequested != null:
return signOutRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( AccountSession account)?  signedIn,TResult Function()?  signOutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionStartedEvent() when started != null:
return started();case SessionSignedInEvent() when signedIn != null:
return signedIn(_that.account);case SessionSignOutRequestedEvent() when signOutRequested != null:
return signOutRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( AccountSession account)  signedIn,required TResult Function()  signOutRequested,}) {final _that = this;
switch (_that) {
case SessionStartedEvent():
return started();case SessionSignedInEvent():
return signedIn(_that.account);case SessionSignOutRequestedEvent():
return signOutRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( AccountSession account)?  signedIn,TResult? Function()?  signOutRequested,}) {final _that = this;
switch (_that) {
case SessionStartedEvent() when started != null:
return started();case SessionSignedInEvent() when signedIn != null:
return signedIn(_that.account);case SessionSignOutRequestedEvent() when signOutRequested != null:
return signOutRequested();case _:
  return null;

}
}

}

/// @nodoc


class SessionStartedEvent with DiagnosticableTreeMixin implements SessionEvent {
  const SessionStartedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionEvent.started'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStartedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionEvent.started()';
}


}




/// @nodoc


class SessionSignedInEvent with DiagnosticableTreeMixin implements SessionEvent {
  const SessionSignedInEvent({required this.account});
  

 final  AccountSession account;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSignedInEventCopyWith<SessionSignedInEvent> get copyWith => _$SessionSignedInEventCopyWithImpl<SessionSignedInEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionEvent.signedIn'))
    ..add(DiagnosticsProperty('account', account));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSignedInEvent&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionEvent.signedIn(account: $account)';
}


}

/// @nodoc
abstract mixin class $SessionSignedInEventCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SessionSignedInEventCopyWith(SessionSignedInEvent value, $Res Function(SessionSignedInEvent) _then) = _$SessionSignedInEventCopyWithImpl;
@useResult
$Res call({
 AccountSession account
});


$AccountSessionCopyWith<$Res> get account;

}
/// @nodoc
class _$SessionSignedInEventCopyWithImpl<$Res>
    implements $SessionSignedInEventCopyWith<$Res> {
  _$SessionSignedInEventCopyWithImpl(this._self, this._then);

  final SessionSignedInEvent _self;
  final $Res Function(SessionSignedInEvent) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(SessionSignedInEvent(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountSession,
  ));
}

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountSessionCopyWith<$Res> get account {
  
  return $AccountSessionCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

/// @nodoc


class SessionSignOutRequestedEvent with DiagnosticableTreeMixin implements SessionEvent {
  const SessionSignOutRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionEvent.signOutRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSignOutRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionEvent.signOutRequested()';
}


}




/// @nodoc
mixin _$SessionState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionState()';
}


}

/// @nodoc
class $SessionStateCopyWith<$Res>  {
$SessionStateCopyWith(SessionState _, $Res Function(SessionState) __);
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionRestoringState value)?  restoring,TResult Function( SessionSignedOutState value)?  signedOut,TResult Function( SessionSignedInState value)?  signedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionRestoringState() when restoring != null:
return restoring(_that);case SessionSignedOutState() when signedOut != null:
return signedOut(_that);case SessionSignedInState() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionRestoringState value)  restoring,required TResult Function( SessionSignedOutState value)  signedOut,required TResult Function( SessionSignedInState value)  signedIn,}){
final _that = this;
switch (_that) {
case SessionRestoringState():
return restoring(_that);case SessionSignedOutState():
return signedOut(_that);case SessionSignedInState():
return signedIn(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionRestoringState value)?  restoring,TResult? Function( SessionSignedOutState value)?  signedOut,TResult? Function( SessionSignedInState value)?  signedIn,}){
final _that = this;
switch (_that) {
case SessionRestoringState() when restoring != null:
return restoring(_that);case SessionSignedOutState() when signedOut != null:
return signedOut(_that);case SessionSignedInState() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  restoring,TResult Function()?  signedOut,TResult Function( AccountSession account)?  signedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionRestoringState() when restoring != null:
return restoring();case SessionSignedOutState() when signedOut != null:
return signedOut();case SessionSignedInState() when signedIn != null:
return signedIn(_that.account);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  restoring,required TResult Function()  signedOut,required TResult Function( AccountSession account)  signedIn,}) {final _that = this;
switch (_that) {
case SessionRestoringState():
return restoring();case SessionSignedOutState():
return signedOut();case SessionSignedInState():
return signedIn(_that.account);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  restoring,TResult? Function()?  signedOut,TResult? Function( AccountSession account)?  signedIn,}) {final _that = this;
switch (_that) {
case SessionRestoringState() when restoring != null:
return restoring();case SessionSignedOutState() when signedOut != null:
return signedOut();case SessionSignedInState() when signedIn != null:
return signedIn(_that.account);case _:
  return null;

}
}

}

/// @nodoc


class SessionRestoringState extends SessionState with DiagnosticableTreeMixin {
  const SessionRestoringState(): super._();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionState.restoring'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRestoringState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionState.restoring()';
}


}




/// @nodoc


class SessionSignedOutState extends SessionState with DiagnosticableTreeMixin {
  const SessionSignedOutState(): super._();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionState.signedOut'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSignedOutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionState.signedOut()';
}


}




/// @nodoc


class SessionSignedInState extends SessionState with DiagnosticableTreeMixin {
  const SessionSignedInState({required this.account}): super._();
  

 final  AccountSession account;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSignedInStateCopyWith<SessionSignedInState> get copyWith => _$SessionSignedInStateCopyWithImpl<SessionSignedInState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SessionState.signedIn'))
    ..add(DiagnosticsProperty('account', account));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSignedInState&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SessionState.signedIn(account: $account)';
}


}

/// @nodoc
abstract mixin class $SessionSignedInStateCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionSignedInStateCopyWith(SessionSignedInState value, $Res Function(SessionSignedInState) _then) = _$SessionSignedInStateCopyWithImpl;
@useResult
$Res call({
 AccountSession account
});


$AccountSessionCopyWith<$Res> get account;

}
/// @nodoc
class _$SessionSignedInStateCopyWithImpl<$Res>
    implements $SessionSignedInStateCopyWith<$Res> {
  _$SessionSignedInStateCopyWithImpl(this._self, this._then);

  final SessionSignedInState _self;
  final $Res Function(SessionSignedInState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(SessionSignedInState(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountSession,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountSessionCopyWith<$Res> get account {
  
  return $AccountSessionCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
