// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent()';
}


}

/// @nodoc
class $BackupEventCopyWith<$Res>  {
$BackupEventCopyWith(BackupEvent _, $Res Function(BackupEvent) __);
}


/// Adds pattern-matching-related methods to [BackupEvent].
extension BackupEventPatterns on BackupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BackupStartedEvent value)?  started,TResult Function( BackupClearedEvent value)?  cleared,TResult Function( BackupChangedEvent value)?  changed,TResult Function( BackupRemoteCheckRequestedEvent value)?  remoteCheckRequested,TResult Function( BackupNewPhraseRequestedEvent value)?  newPhraseRequested,TResult Function( BackupTurnOnRequestedEvent value)?  turnOnRequested,TResult Function( BackupRestoreRequestedEvent value)?  restoreRequested,TResult Function( BackupBackUpNowRequestedEvent value)?  backUpNowRequested,TResult Function( BackupTurnOffRequestedEvent value)?  turnOffRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BackupStartedEvent() when started != null:
return started(_that);case BackupClearedEvent() when cleared != null:
return cleared(_that);case BackupChangedEvent() when changed != null:
return changed(_that);case BackupRemoteCheckRequestedEvent() when remoteCheckRequested != null:
return remoteCheckRequested(_that);case BackupNewPhraseRequestedEvent() when newPhraseRequested != null:
return newPhraseRequested(_that);case BackupTurnOnRequestedEvent() when turnOnRequested != null:
return turnOnRequested(_that);case BackupRestoreRequestedEvent() when restoreRequested != null:
return restoreRequested(_that);case BackupBackUpNowRequestedEvent() when backUpNowRequested != null:
return backUpNowRequested(_that);case BackupTurnOffRequestedEvent() when turnOffRequested != null:
return turnOffRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BackupStartedEvent value)  started,required TResult Function( BackupClearedEvent value)  cleared,required TResult Function( BackupChangedEvent value)  changed,required TResult Function( BackupRemoteCheckRequestedEvent value)  remoteCheckRequested,required TResult Function( BackupNewPhraseRequestedEvent value)  newPhraseRequested,required TResult Function( BackupTurnOnRequestedEvent value)  turnOnRequested,required TResult Function( BackupRestoreRequestedEvent value)  restoreRequested,required TResult Function( BackupBackUpNowRequestedEvent value)  backUpNowRequested,required TResult Function( BackupTurnOffRequestedEvent value)  turnOffRequested,}){
final _that = this;
switch (_that) {
case BackupStartedEvent():
return started(_that);case BackupClearedEvent():
return cleared(_that);case BackupChangedEvent():
return changed(_that);case BackupRemoteCheckRequestedEvent():
return remoteCheckRequested(_that);case BackupNewPhraseRequestedEvent():
return newPhraseRequested(_that);case BackupTurnOnRequestedEvent():
return turnOnRequested(_that);case BackupRestoreRequestedEvent():
return restoreRequested(_that);case BackupBackUpNowRequestedEvent():
return backUpNowRequested(_that);case BackupTurnOffRequestedEvent():
return turnOffRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BackupStartedEvent value)?  started,TResult? Function( BackupClearedEvent value)?  cleared,TResult? Function( BackupChangedEvent value)?  changed,TResult? Function( BackupRemoteCheckRequestedEvent value)?  remoteCheckRequested,TResult? Function( BackupNewPhraseRequestedEvent value)?  newPhraseRequested,TResult? Function( BackupTurnOnRequestedEvent value)?  turnOnRequested,TResult? Function( BackupRestoreRequestedEvent value)?  restoreRequested,TResult? Function( BackupBackUpNowRequestedEvent value)?  backUpNowRequested,TResult? Function( BackupTurnOffRequestedEvent value)?  turnOffRequested,}){
final _that = this;
switch (_that) {
case BackupStartedEvent() when started != null:
return started(_that);case BackupClearedEvent() when cleared != null:
return cleared(_that);case BackupChangedEvent() when changed != null:
return changed(_that);case BackupRemoteCheckRequestedEvent() when remoteCheckRequested != null:
return remoteCheckRequested(_that);case BackupNewPhraseRequestedEvent() when newPhraseRequested != null:
return newPhraseRequested(_that);case BackupTurnOnRequestedEvent() when turnOnRequested != null:
return turnOnRequested(_that);case BackupRestoreRequestedEvent() when restoreRequested != null:
return restoreRequested(_that);case BackupBackUpNowRequestedEvent() when backUpNowRequested != null:
return backUpNowRequested(_that);case BackupTurnOffRequestedEvent() when turnOffRequested != null:
return turnOffRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String accountId)?  started,TResult Function()?  cleared,TResult Function( List<Invite> invites)?  changed,TResult Function()?  remoteCheckRequested,TResult Function()?  newPhraseRequested,TResult Function()?  turnOnRequested,TResult Function( String phrase)?  restoreRequested,TResult Function()?  backUpNowRequested,TResult Function()?  turnOffRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BackupStartedEvent() when started != null:
return started(_that.accountId);case BackupClearedEvent() when cleared != null:
return cleared();case BackupChangedEvent() when changed != null:
return changed(_that.invites);case BackupRemoteCheckRequestedEvent() when remoteCheckRequested != null:
return remoteCheckRequested();case BackupNewPhraseRequestedEvent() when newPhraseRequested != null:
return newPhraseRequested();case BackupTurnOnRequestedEvent() when turnOnRequested != null:
return turnOnRequested();case BackupRestoreRequestedEvent() when restoreRequested != null:
return restoreRequested(_that.phrase);case BackupBackUpNowRequestedEvent() when backUpNowRequested != null:
return backUpNowRequested();case BackupTurnOffRequestedEvent() when turnOffRequested != null:
return turnOffRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String accountId)  started,required TResult Function()  cleared,required TResult Function( List<Invite> invites)  changed,required TResult Function()  remoteCheckRequested,required TResult Function()  newPhraseRequested,required TResult Function()  turnOnRequested,required TResult Function( String phrase)  restoreRequested,required TResult Function()  backUpNowRequested,required TResult Function()  turnOffRequested,}) {final _that = this;
switch (_that) {
case BackupStartedEvent():
return started(_that.accountId);case BackupClearedEvent():
return cleared();case BackupChangedEvent():
return changed(_that.invites);case BackupRemoteCheckRequestedEvent():
return remoteCheckRequested();case BackupNewPhraseRequestedEvent():
return newPhraseRequested();case BackupTurnOnRequestedEvent():
return turnOnRequested();case BackupRestoreRequestedEvent():
return restoreRequested(_that.phrase);case BackupBackUpNowRequestedEvent():
return backUpNowRequested();case BackupTurnOffRequestedEvent():
return turnOffRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String accountId)?  started,TResult? Function()?  cleared,TResult? Function( List<Invite> invites)?  changed,TResult? Function()?  remoteCheckRequested,TResult? Function()?  newPhraseRequested,TResult? Function()?  turnOnRequested,TResult? Function( String phrase)?  restoreRequested,TResult? Function()?  backUpNowRequested,TResult? Function()?  turnOffRequested,}) {final _that = this;
switch (_that) {
case BackupStartedEvent() when started != null:
return started(_that.accountId);case BackupClearedEvent() when cleared != null:
return cleared();case BackupChangedEvent() when changed != null:
return changed(_that.invites);case BackupRemoteCheckRequestedEvent() when remoteCheckRequested != null:
return remoteCheckRequested();case BackupNewPhraseRequestedEvent() when newPhraseRequested != null:
return newPhraseRequested();case BackupTurnOnRequestedEvent() when turnOnRequested != null:
return turnOnRequested();case BackupRestoreRequestedEvent() when restoreRequested != null:
return restoreRequested(_that.phrase);case BackupBackUpNowRequestedEvent() when backUpNowRequested != null:
return backUpNowRequested();case BackupTurnOffRequestedEvent() when turnOffRequested != null:
return turnOffRequested();case _:
  return null;

}
}

}

/// @nodoc


class BackupStartedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupStartedEvent({required this.accountId});
  

 final  String accountId;

/// Create a copy of BackupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupStartedEventCopyWith<BackupStartedEvent> get copyWith => _$BackupStartedEventCopyWithImpl<BackupStartedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.started'))
    ..add(DiagnosticsProperty('accountId', accountId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupStartedEvent&&(identical(other.accountId, accountId) || other.accountId == accountId));
}


@override
int get hashCode => Object.hash(runtimeType,accountId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.started(accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class $BackupStartedEventCopyWith<$Res> implements $BackupEventCopyWith<$Res> {
  factory $BackupStartedEventCopyWith(BackupStartedEvent value, $Res Function(BackupStartedEvent) _then) = _$BackupStartedEventCopyWithImpl;
@useResult
$Res call({
 String accountId
});




}
/// @nodoc
class _$BackupStartedEventCopyWithImpl<$Res>
    implements $BackupStartedEventCopyWith<$Res> {
  _$BackupStartedEventCopyWithImpl(this._self, this._then);

  final BackupStartedEvent _self;
  final $Res Function(BackupStartedEvent) _then;

/// Create a copy of BackupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accountId = null,}) {
  return _then(BackupStartedEvent(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BackupClearedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupClearedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.cleared'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupClearedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.cleared()';
}


}




/// @nodoc


class BackupChangedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupChangedEvent({required final  List<Invite> invites}): _invites = invites;
  

 final  List<Invite> _invites;
 List<Invite> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}


/// Create a copy of BackupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupChangedEventCopyWith<BackupChangedEvent> get copyWith => _$BackupChangedEventCopyWithImpl<BackupChangedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.changed'))
    ..add(DiagnosticsProperty('invites', invites));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupChangedEvent&&const DeepCollectionEquality().equals(other._invites, _invites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_invites));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.changed(invites: $invites)';
}


}

/// @nodoc
abstract mixin class $BackupChangedEventCopyWith<$Res> implements $BackupEventCopyWith<$Res> {
  factory $BackupChangedEventCopyWith(BackupChangedEvent value, $Res Function(BackupChangedEvent) _then) = _$BackupChangedEventCopyWithImpl;
@useResult
$Res call({
 List<Invite> invites
});




}
/// @nodoc
class _$BackupChangedEventCopyWithImpl<$Res>
    implements $BackupChangedEventCopyWith<$Res> {
  _$BackupChangedEventCopyWithImpl(this._self, this._then);

  final BackupChangedEvent _self;
  final $Res Function(BackupChangedEvent) _then;

/// Create a copy of BackupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invites = null,}) {
  return _then(BackupChangedEvent(
invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<Invite>,
  ));
}


}

/// @nodoc


class BackupRemoteCheckRequestedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupRemoteCheckRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.remoteCheckRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupRemoteCheckRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.remoteCheckRequested()';
}


}




/// @nodoc


class BackupNewPhraseRequestedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupNewPhraseRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.newPhraseRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupNewPhraseRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.newPhraseRequested()';
}


}




/// @nodoc


class BackupTurnOnRequestedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupTurnOnRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.turnOnRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupTurnOnRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.turnOnRequested()';
}


}




/// @nodoc


class BackupRestoreRequestedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupRestoreRequestedEvent({required this.phrase});
  

 final  String phrase;

/// Create a copy of BackupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupRestoreRequestedEventCopyWith<BackupRestoreRequestedEvent> get copyWith => _$BackupRestoreRequestedEventCopyWithImpl<BackupRestoreRequestedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.restoreRequested'))
    ..add(DiagnosticsProperty('phrase', phrase));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupRestoreRequestedEvent&&(identical(other.phrase, phrase) || other.phrase == phrase));
}


@override
int get hashCode => Object.hash(runtimeType,phrase);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.restoreRequested(phrase: $phrase)';
}


}

/// @nodoc
abstract mixin class $BackupRestoreRequestedEventCopyWith<$Res> implements $BackupEventCopyWith<$Res> {
  factory $BackupRestoreRequestedEventCopyWith(BackupRestoreRequestedEvent value, $Res Function(BackupRestoreRequestedEvent) _then) = _$BackupRestoreRequestedEventCopyWithImpl;
@useResult
$Res call({
 String phrase
});




}
/// @nodoc
class _$BackupRestoreRequestedEventCopyWithImpl<$Res>
    implements $BackupRestoreRequestedEventCopyWith<$Res> {
  _$BackupRestoreRequestedEventCopyWithImpl(this._self, this._then);

  final BackupRestoreRequestedEvent _self;
  final $Res Function(BackupRestoreRequestedEvent) _then;

/// Create a copy of BackupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phrase = null,}) {
  return _then(BackupRestoreRequestedEvent(
phrase: null == phrase ? _self.phrase : phrase // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BackupBackUpNowRequestedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupBackUpNowRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.backUpNowRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupBackUpNowRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.backUpNowRequested()';
}


}




/// @nodoc


class BackupTurnOffRequestedEvent with DiagnosticableTreeMixin implements BackupEvent {
  const BackupTurnOffRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupEvent.turnOffRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupTurnOffRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupEvent.turnOffRequested()';
}


}




/// @nodoc
mixin _$BackupState implements DiagnosticableTreeMixin {

 String? get accountId;/// This phone holds the key for the signed-in account.
 bool get on; bool get syncing; DateTime? get lastBackup;/// The latest archive on the phone, which a sync uploads.
 List<Invite> get local;/// [local] has been reported since sign-in.
 bool get hasLocal;/// The latest merge for the invites to adopt; [mergedRevision] changes
/// with each one.
 List<Invite>? get merged; int get mergedRevision;/// Whether this account has a backup from any phone.
 RequestStatus<bool>? get remoteCheck;/// A new phrase, shown until backup is on.
 List<String>? get phrase; Map<BackupAction, RequestStatus<Unit>> get actions;
/// Create a copy of BackupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupStateCopyWith<BackupState> get copyWith => _$BackupStateCopyWithImpl<BackupState>(this as BackupState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupState'))
    ..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('on', on))..add(DiagnosticsProperty('syncing', syncing))..add(DiagnosticsProperty('lastBackup', lastBackup))..add(DiagnosticsProperty('local', local))..add(DiagnosticsProperty('hasLocal', hasLocal))..add(DiagnosticsProperty('merged', merged))..add(DiagnosticsProperty('mergedRevision', mergedRevision))..add(DiagnosticsProperty('remoteCheck', remoteCheck))..add(DiagnosticsProperty('phrase', phrase))..add(DiagnosticsProperty('actions', actions));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupState&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.on, on) || other.on == on)&&(identical(other.syncing, syncing) || other.syncing == syncing)&&(identical(other.lastBackup, lastBackup) || other.lastBackup == lastBackup)&&const DeepCollectionEquality().equals(other.local, local)&&(identical(other.hasLocal, hasLocal) || other.hasLocal == hasLocal)&&const DeepCollectionEquality().equals(other.merged, merged)&&(identical(other.mergedRevision, mergedRevision) || other.mergedRevision == mergedRevision)&&(identical(other.remoteCheck, remoteCheck) || other.remoteCheck == remoteCheck)&&const DeepCollectionEquality().equals(other.phrase, phrase)&&const DeepCollectionEquality().equals(other.actions, actions));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,on,syncing,lastBackup,const DeepCollectionEquality().hash(local),hasLocal,const DeepCollectionEquality().hash(merged),mergedRevision,remoteCheck,const DeepCollectionEquality().hash(phrase),const DeepCollectionEquality().hash(actions));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupState(accountId: $accountId, on: $on, syncing: $syncing, lastBackup: $lastBackup, local: $local, hasLocal: $hasLocal, merged: $merged, mergedRevision: $mergedRevision, remoteCheck: $remoteCheck, phrase: $phrase, actions: $actions)';
}


}

/// @nodoc
abstract mixin class $BackupStateCopyWith<$Res>  {
  factory $BackupStateCopyWith(BackupState value, $Res Function(BackupState) _then) = _$BackupStateCopyWithImpl;
@useResult
$Res call({
 String? accountId, bool on, bool syncing, DateTime? lastBackup, List<Invite> local, bool hasLocal, List<Invite>? merged, int mergedRevision, RequestStatus<bool>? remoteCheck, List<String>? phrase, Map<BackupAction, RequestStatus<Unit>> actions
});


$RequestStatusCopyWith<bool, $Res>? get remoteCheck;

}
/// @nodoc
class _$BackupStateCopyWithImpl<$Res>
    implements $BackupStateCopyWith<$Res> {
  _$BackupStateCopyWithImpl(this._self, this._then);

  final BackupState _self;
  final $Res Function(BackupState) _then;

/// Create a copy of BackupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = freezed,Object? on = null,Object? syncing = null,Object? lastBackup = freezed,Object? local = null,Object? hasLocal = null,Object? merged = freezed,Object? mergedRevision = null,Object? remoteCheck = freezed,Object? phrase = freezed,Object? actions = null,}) {
  return _then(_self.copyWith(
accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,on: null == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as bool,syncing: null == syncing ? _self.syncing : syncing // ignore: cast_nullable_to_non_nullable
as bool,lastBackup: freezed == lastBackup ? _self.lastBackup : lastBackup // ignore: cast_nullable_to_non_nullable
as DateTime?,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as List<Invite>,hasLocal: null == hasLocal ? _self.hasLocal : hasLocal // ignore: cast_nullable_to_non_nullable
as bool,merged: freezed == merged ? _self.merged : merged // ignore: cast_nullable_to_non_nullable
as List<Invite>?,mergedRevision: null == mergedRevision ? _self.mergedRevision : mergedRevision // ignore: cast_nullable_to_non_nullable
as int,remoteCheck: freezed == remoteCheck ? _self.remoteCheck : remoteCheck // ignore: cast_nullable_to_non_nullable
as RequestStatus<bool>?,phrase: freezed == phrase ? _self.phrase : phrase // ignore: cast_nullable_to_non_nullable
as List<String>?,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as Map<BackupAction, RequestStatus<Unit>>,
  ));
}
/// Create a copy of BackupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestStatusCopyWith<bool, $Res>? get remoteCheck {
    if (_self.remoteCheck == null) {
    return null;
  }

  return $RequestStatusCopyWith<bool, $Res>(_self.remoteCheck!, (value) {
    return _then(_self.copyWith(remoteCheck: value));
  });
}
}


/// Adds pattern-matching-related methods to [BackupState].
extension BackupStatePatterns on BackupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupState value)  $default,){
final _that = this;
switch (_that) {
case _BackupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupState value)?  $default,){
final _that = this;
switch (_that) {
case _BackupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accountId,  bool on,  bool syncing,  DateTime? lastBackup,  List<Invite> local,  bool hasLocal,  List<Invite>? merged,  int mergedRevision,  RequestStatus<bool>? remoteCheck,  List<String>? phrase,  Map<BackupAction, RequestStatus<Unit>> actions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupState() when $default != null:
return $default(_that.accountId,_that.on,_that.syncing,_that.lastBackup,_that.local,_that.hasLocal,_that.merged,_that.mergedRevision,_that.remoteCheck,_that.phrase,_that.actions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accountId,  bool on,  bool syncing,  DateTime? lastBackup,  List<Invite> local,  bool hasLocal,  List<Invite>? merged,  int mergedRevision,  RequestStatus<bool>? remoteCheck,  List<String>? phrase,  Map<BackupAction, RequestStatus<Unit>> actions)  $default,) {final _that = this;
switch (_that) {
case _BackupState():
return $default(_that.accountId,_that.on,_that.syncing,_that.lastBackup,_that.local,_that.hasLocal,_that.merged,_that.mergedRevision,_that.remoteCheck,_that.phrase,_that.actions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accountId,  bool on,  bool syncing,  DateTime? lastBackup,  List<Invite> local,  bool hasLocal,  List<Invite>? merged,  int mergedRevision,  RequestStatus<bool>? remoteCheck,  List<String>? phrase,  Map<BackupAction, RequestStatus<Unit>> actions)?  $default,) {final _that = this;
switch (_that) {
case _BackupState() when $default != null:
return $default(_that.accountId,_that.on,_that.syncing,_that.lastBackup,_that.local,_that.hasLocal,_that.merged,_that.mergedRevision,_that.remoteCheck,_that.phrase,_that.actions);case _:
  return null;

}
}

}

/// @nodoc


class _BackupState with DiagnosticableTreeMixin implements BackupState {
  const _BackupState({this.accountId, this.on = false, this.syncing = false, this.lastBackup, final  List<Invite> local = const [], this.hasLocal = false, final  List<Invite>? merged, this.mergedRevision = 0, this.remoteCheck, final  List<String>? phrase, final  Map<BackupAction, RequestStatus<Unit>> actions = const {}}): _local = local,_merged = merged,_phrase = phrase,_actions = actions;
  

@override final  String? accountId;
/// This phone holds the key for the signed-in account.
@override@JsonKey() final  bool on;
@override@JsonKey() final  bool syncing;
@override final  DateTime? lastBackup;
/// The latest archive on the phone, which a sync uploads.
 final  List<Invite> _local;
/// The latest archive on the phone, which a sync uploads.
@override@JsonKey() List<Invite> get local {
  if (_local is EqualUnmodifiableListView) return _local;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_local);
}

/// [local] has been reported since sign-in.
@override@JsonKey() final  bool hasLocal;
/// The latest merge for the invites to adopt; [mergedRevision] changes
/// with each one.
 final  List<Invite>? _merged;
/// The latest merge for the invites to adopt; [mergedRevision] changes
/// with each one.
@override List<Invite>? get merged {
  final value = _merged;
  if (value == null) return null;
  if (_merged is EqualUnmodifiableListView) return _merged;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  int mergedRevision;
/// Whether this account has a backup from any phone.
@override final  RequestStatus<bool>? remoteCheck;
/// A new phrase, shown until backup is on.
 final  List<String>? _phrase;
/// A new phrase, shown until backup is on.
@override List<String>? get phrase {
  final value = _phrase;
  if (value == null) return null;
  if (_phrase is EqualUnmodifiableListView) return _phrase;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<BackupAction, RequestStatus<Unit>> _actions;
@override@JsonKey() Map<BackupAction, RequestStatus<Unit>> get actions {
  if (_actions is EqualUnmodifiableMapView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_actions);
}


/// Create a copy of BackupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupStateCopyWith<_BackupState> get copyWith => __$BackupStateCopyWithImpl<_BackupState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BackupState'))
    ..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('on', on))..add(DiagnosticsProperty('syncing', syncing))..add(DiagnosticsProperty('lastBackup', lastBackup))..add(DiagnosticsProperty('local', local))..add(DiagnosticsProperty('hasLocal', hasLocal))..add(DiagnosticsProperty('merged', merged))..add(DiagnosticsProperty('mergedRevision', mergedRevision))..add(DiagnosticsProperty('remoteCheck', remoteCheck))..add(DiagnosticsProperty('phrase', phrase))..add(DiagnosticsProperty('actions', actions));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupState&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.on, on) || other.on == on)&&(identical(other.syncing, syncing) || other.syncing == syncing)&&(identical(other.lastBackup, lastBackup) || other.lastBackup == lastBackup)&&const DeepCollectionEquality().equals(other._local, _local)&&(identical(other.hasLocal, hasLocal) || other.hasLocal == hasLocal)&&const DeepCollectionEquality().equals(other._merged, _merged)&&(identical(other.mergedRevision, mergedRevision) || other.mergedRevision == mergedRevision)&&(identical(other.remoteCheck, remoteCheck) || other.remoteCheck == remoteCheck)&&const DeepCollectionEquality().equals(other._phrase, _phrase)&&const DeepCollectionEquality().equals(other._actions, _actions));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,on,syncing,lastBackup,const DeepCollectionEquality().hash(_local),hasLocal,const DeepCollectionEquality().hash(_merged),mergedRevision,remoteCheck,const DeepCollectionEquality().hash(_phrase),const DeepCollectionEquality().hash(_actions));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BackupState(accountId: $accountId, on: $on, syncing: $syncing, lastBackup: $lastBackup, local: $local, hasLocal: $hasLocal, merged: $merged, mergedRevision: $mergedRevision, remoteCheck: $remoteCheck, phrase: $phrase, actions: $actions)';
}


}

/// @nodoc
abstract mixin class _$BackupStateCopyWith<$Res> implements $BackupStateCopyWith<$Res> {
  factory _$BackupStateCopyWith(_BackupState value, $Res Function(_BackupState) _then) = __$BackupStateCopyWithImpl;
@override @useResult
$Res call({
 String? accountId, bool on, bool syncing, DateTime? lastBackup, List<Invite> local, bool hasLocal, List<Invite>? merged, int mergedRevision, RequestStatus<bool>? remoteCheck, List<String>? phrase, Map<BackupAction, RequestStatus<Unit>> actions
});


@override $RequestStatusCopyWith<bool, $Res>? get remoteCheck;

}
/// @nodoc
class __$BackupStateCopyWithImpl<$Res>
    implements _$BackupStateCopyWith<$Res> {
  __$BackupStateCopyWithImpl(this._self, this._then);

  final _BackupState _self;
  final $Res Function(_BackupState) _then;

/// Create a copy of BackupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = freezed,Object? on = null,Object? syncing = null,Object? lastBackup = freezed,Object? local = null,Object? hasLocal = null,Object? merged = freezed,Object? mergedRevision = null,Object? remoteCheck = freezed,Object? phrase = freezed,Object? actions = null,}) {
  return _then(_BackupState(
accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,on: null == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as bool,syncing: null == syncing ? _self.syncing : syncing // ignore: cast_nullable_to_non_nullable
as bool,lastBackup: freezed == lastBackup ? _self.lastBackup : lastBackup // ignore: cast_nullable_to_non_nullable
as DateTime?,local: null == local ? _self._local : local // ignore: cast_nullable_to_non_nullable
as List<Invite>,hasLocal: null == hasLocal ? _self.hasLocal : hasLocal // ignore: cast_nullable_to_non_nullable
as bool,merged: freezed == merged ? _self._merged : merged // ignore: cast_nullable_to_non_nullable
as List<Invite>?,mergedRevision: null == mergedRevision ? _self.mergedRevision : mergedRevision // ignore: cast_nullable_to_non_nullable
as int,remoteCheck: freezed == remoteCheck ? _self.remoteCheck : remoteCheck // ignore: cast_nullable_to_non_nullable
as RequestStatus<bool>?,phrase: freezed == phrase ? _self._phrase : phrase // ignore: cast_nullable_to_non_nullable
as List<String>?,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as Map<BackupAction, RequestStatus<Unit>>,
  ));
}

/// Create a copy of BackupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestStatusCopyWith<bool, $Res>? get remoteCheck {
    if (_self.remoteCheck == null) {
    return null;
  }

  return $RequestStatusCopyWith<bool, $Res>(_self.remoteCheck!, (value) {
    return _then(_self.copyWith(remoteCheck: value));
  });
}
}

// dart format on
