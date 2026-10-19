// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invites_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvitesEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent()';
}


}

/// @nodoc
class $InvitesEventCopyWith<$Res>  {
$InvitesEventCopyWith(InvitesEvent _, $Res Function(InvitesEvent) __);
}


/// Adds pattern-matching-related methods to [InvitesEvent].
extension InvitesEventPatterns on InvitesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InvitesStartedEvent value)?  started,TResult Function( InvitesClearedEvent value)?  cleared,TResult Function( InvitesRefreshRequestedEvent value)?  refreshRequested,TResult Function( InvitesCreateRequestedEvent value)?  createRequested,TResult Function( InvitesRevokeRequestedEvent value)?  revokeRequested,TResult Function( InvitesBackupAdoptedEvent value)?  backupAdopted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InvitesStartedEvent() when started != null:
return started(_that);case InvitesClearedEvent() when cleared != null:
return cleared(_that);case InvitesRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested(_that);case InvitesCreateRequestedEvent() when createRequested != null:
return createRequested(_that);case InvitesRevokeRequestedEvent() when revokeRequested != null:
return revokeRequested(_that);case InvitesBackupAdoptedEvent() when backupAdopted != null:
return backupAdopted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InvitesStartedEvent value)  started,required TResult Function( InvitesClearedEvent value)  cleared,required TResult Function( InvitesRefreshRequestedEvent value)  refreshRequested,required TResult Function( InvitesCreateRequestedEvent value)  createRequested,required TResult Function( InvitesRevokeRequestedEvent value)  revokeRequested,required TResult Function( InvitesBackupAdoptedEvent value)  backupAdopted,}){
final _that = this;
switch (_that) {
case InvitesStartedEvent():
return started(_that);case InvitesClearedEvent():
return cleared(_that);case InvitesRefreshRequestedEvent():
return refreshRequested(_that);case InvitesCreateRequestedEvent():
return createRequested(_that);case InvitesRevokeRequestedEvent():
return revokeRequested(_that);case InvitesBackupAdoptedEvent():
return backupAdopted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InvitesStartedEvent value)?  started,TResult? Function( InvitesClearedEvent value)?  cleared,TResult? Function( InvitesRefreshRequestedEvent value)?  refreshRequested,TResult? Function( InvitesCreateRequestedEvent value)?  createRequested,TResult? Function( InvitesRevokeRequestedEvent value)?  revokeRequested,TResult? Function( InvitesBackupAdoptedEvent value)?  backupAdopted,}){
final _that = this;
switch (_that) {
case InvitesStartedEvent() when started != null:
return started(_that);case InvitesClearedEvent() when cleared != null:
return cleared(_that);case InvitesRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested(_that);case InvitesCreateRequestedEvent() when createRequested != null:
return createRequested(_that);case InvitesRevokeRequestedEvent() when revokeRequested != null:
return revokeRequested(_that);case InvitesBackupAdoptedEvent() when backupAdopted != null:
return backupAdopted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AccountSession account)?  started,TResult Function()?  cleared,TResult Function()?  refreshRequested,TResult Function( String requestId,  InviteDraft draft)?  createRequested,TResult Function( String requestId,  String inviteId)?  revokeRequested,TResult Function( String accountId,  List<Invite> invites)?  backupAdopted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InvitesStartedEvent() when started != null:
return started(_that.account);case InvitesClearedEvent() when cleared != null:
return cleared();case InvitesRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested();case InvitesCreateRequestedEvent() when createRequested != null:
return createRequested(_that.requestId,_that.draft);case InvitesRevokeRequestedEvent() when revokeRequested != null:
return revokeRequested(_that.requestId,_that.inviteId);case InvitesBackupAdoptedEvent() when backupAdopted != null:
return backupAdopted(_that.accountId,_that.invites);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AccountSession account)  started,required TResult Function()  cleared,required TResult Function()  refreshRequested,required TResult Function( String requestId,  InviteDraft draft)  createRequested,required TResult Function( String requestId,  String inviteId)  revokeRequested,required TResult Function( String accountId,  List<Invite> invites)  backupAdopted,}) {final _that = this;
switch (_that) {
case InvitesStartedEvent():
return started(_that.account);case InvitesClearedEvent():
return cleared();case InvitesRefreshRequestedEvent():
return refreshRequested();case InvitesCreateRequestedEvent():
return createRequested(_that.requestId,_that.draft);case InvitesRevokeRequestedEvent():
return revokeRequested(_that.requestId,_that.inviteId);case InvitesBackupAdoptedEvent():
return backupAdopted(_that.accountId,_that.invites);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AccountSession account)?  started,TResult? Function()?  cleared,TResult? Function()?  refreshRequested,TResult? Function( String requestId,  InviteDraft draft)?  createRequested,TResult? Function( String requestId,  String inviteId)?  revokeRequested,TResult? Function( String accountId,  List<Invite> invites)?  backupAdopted,}) {final _that = this;
switch (_that) {
case InvitesStartedEvent() when started != null:
return started(_that.account);case InvitesClearedEvent() when cleared != null:
return cleared();case InvitesRefreshRequestedEvent() when refreshRequested != null:
return refreshRequested();case InvitesCreateRequestedEvent() when createRequested != null:
return createRequested(_that.requestId,_that.draft);case InvitesRevokeRequestedEvent() when revokeRequested != null:
return revokeRequested(_that.requestId,_that.inviteId);case InvitesBackupAdoptedEvent() when backupAdopted != null:
return backupAdopted(_that.accountId,_that.invites);case _:
  return null;

}
}

}

/// @nodoc


class InvitesStartedEvent with DiagnosticableTreeMixin implements InvitesEvent {
  const InvitesStartedEvent({required this.account});
  

 final  AccountSession account;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitesStartedEventCopyWith<InvitesStartedEvent> get copyWith => _$InvitesStartedEventCopyWithImpl<InvitesStartedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent.started'))
    ..add(DiagnosticsProperty('account', account));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesStartedEvent&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent.started(account: $account)';
}


}

/// @nodoc
abstract mixin class $InvitesStartedEventCopyWith<$Res> implements $InvitesEventCopyWith<$Res> {
  factory $InvitesStartedEventCopyWith(InvitesStartedEvent value, $Res Function(InvitesStartedEvent) _then) = _$InvitesStartedEventCopyWithImpl;
@useResult
$Res call({
 AccountSession account
});


$AccountSessionCopyWith<$Res> get account;

}
/// @nodoc
class _$InvitesStartedEventCopyWithImpl<$Res>
    implements $InvitesStartedEventCopyWith<$Res> {
  _$InvitesStartedEventCopyWithImpl(this._self, this._then);

  final InvitesStartedEvent _self;
  final $Res Function(InvitesStartedEvent) _then;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(InvitesStartedEvent(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountSession,
  ));
}

/// Create a copy of InvitesEvent
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


class InvitesClearedEvent with DiagnosticableTreeMixin implements InvitesEvent {
  const InvitesClearedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent.cleared'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesClearedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent.cleared()';
}


}




/// @nodoc


class InvitesRefreshRequestedEvent with DiagnosticableTreeMixin implements InvitesEvent {
  const InvitesRefreshRequestedEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent.refreshRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesRefreshRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent.refreshRequested()';
}


}




/// @nodoc


class InvitesCreateRequestedEvent with DiagnosticableTreeMixin implements InvitesEvent {
  const InvitesCreateRequestedEvent({required this.requestId, required this.draft});
  

 final  String requestId;
 final  InviteDraft draft;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitesCreateRequestedEventCopyWith<InvitesCreateRequestedEvent> get copyWith => _$InvitesCreateRequestedEventCopyWithImpl<InvitesCreateRequestedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent.createRequested'))
    ..add(DiagnosticsProperty('requestId', requestId))..add(DiagnosticsProperty('draft', draft));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesCreateRequestedEvent&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,draft);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent.createRequested(requestId: $requestId, draft: $draft)';
}


}

/// @nodoc
abstract mixin class $InvitesCreateRequestedEventCopyWith<$Res> implements $InvitesEventCopyWith<$Res> {
  factory $InvitesCreateRequestedEventCopyWith(InvitesCreateRequestedEvent value, $Res Function(InvitesCreateRequestedEvent) _then) = _$InvitesCreateRequestedEventCopyWithImpl;
@useResult
$Res call({
 String requestId, InviteDraft draft
});


$InviteDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$InvitesCreateRequestedEventCopyWithImpl<$Res>
    implements $InvitesCreateRequestedEventCopyWith<$Res> {
  _$InvitesCreateRequestedEventCopyWithImpl(this._self, this._then);

  final InvitesCreateRequestedEvent _self;
  final $Res Function(InvitesCreateRequestedEvent) _then;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? draft = null,}) {
  return _then(InvitesCreateRequestedEvent(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as InviteDraft,
  ));
}

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteDraftCopyWith<$Res> get draft {
  
  return $InviteDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

/// @nodoc


class InvitesRevokeRequestedEvent with DiagnosticableTreeMixin implements InvitesEvent {
  const InvitesRevokeRequestedEvent({required this.requestId, required this.inviteId});
  

 final  String requestId;
 final  String inviteId;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitesRevokeRequestedEventCopyWith<InvitesRevokeRequestedEvent> get copyWith => _$InvitesRevokeRequestedEventCopyWithImpl<InvitesRevokeRequestedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent.revokeRequested'))
    ..add(DiagnosticsProperty('requestId', requestId))..add(DiagnosticsProperty('inviteId', inviteId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesRevokeRequestedEvent&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.inviteId, inviteId) || other.inviteId == inviteId));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,inviteId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent.revokeRequested(requestId: $requestId, inviteId: $inviteId)';
}


}

/// @nodoc
abstract mixin class $InvitesRevokeRequestedEventCopyWith<$Res> implements $InvitesEventCopyWith<$Res> {
  factory $InvitesRevokeRequestedEventCopyWith(InvitesRevokeRequestedEvent value, $Res Function(InvitesRevokeRequestedEvent) _then) = _$InvitesRevokeRequestedEventCopyWithImpl;
@useResult
$Res call({
 String requestId, String inviteId
});




}
/// @nodoc
class _$InvitesRevokeRequestedEventCopyWithImpl<$Res>
    implements $InvitesRevokeRequestedEventCopyWith<$Res> {
  _$InvitesRevokeRequestedEventCopyWithImpl(this._self, this._then);

  final InvitesRevokeRequestedEvent _self;
  final $Res Function(InvitesRevokeRequestedEvent) _then;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? inviteId = null,}) {
  return _then(InvitesRevokeRequestedEvent(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,inviteId: null == inviteId ? _self.inviteId : inviteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvitesBackupAdoptedEvent with DiagnosticableTreeMixin implements InvitesEvent {
  const InvitesBackupAdoptedEvent({required this.accountId, required final  List<Invite> invites}): _invites = invites;
  

 final  String accountId;
 final  List<Invite> _invites;
 List<Invite> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}


/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitesBackupAdoptedEventCopyWith<InvitesBackupAdoptedEvent> get copyWith => _$InvitesBackupAdoptedEventCopyWithImpl<InvitesBackupAdoptedEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesEvent.backupAdopted'))
    ..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('invites', invites));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesBackupAdoptedEvent&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other._invites, _invites));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,const DeepCollectionEquality().hash(_invites));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesEvent.backupAdopted(accountId: $accountId, invites: $invites)';
}


}

/// @nodoc
abstract mixin class $InvitesBackupAdoptedEventCopyWith<$Res> implements $InvitesEventCopyWith<$Res> {
  factory $InvitesBackupAdoptedEventCopyWith(InvitesBackupAdoptedEvent value, $Res Function(InvitesBackupAdoptedEvent) _then) = _$InvitesBackupAdoptedEventCopyWithImpl;
@useResult
$Res call({
 String accountId, List<Invite> invites
});




}
/// @nodoc
class _$InvitesBackupAdoptedEventCopyWithImpl<$Res>
    implements $InvitesBackupAdoptedEventCopyWith<$Res> {
  _$InvitesBackupAdoptedEventCopyWithImpl(this._self, this._then);

  final InvitesBackupAdoptedEvent _self;
  final $Res Function(InvitesBackupAdoptedEvent) _then;

/// Create a copy of InvitesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? invites = null,}) {
  return _then(InvitesBackupAdoptedEvent(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<Invite>,
  ));
}


}

/// @nodoc
mixin _$InvitesState implements DiagnosticableTreeMixin {

/// The estate account the invites belong to; null when signed out.
 String? get accountId; String? get siteId; List<Invite> get invites;/// The archive has been read.
 bool get loaded;/// The latest fetch from ATG.
 RequestStatus<Unit>? get refresh;/// Creates, by the request id their event carried.
 Map<String, RequestStatus<Invite>> get requests;/// Revokes, by the request id their event carried.
 Map<String, RequestStatus<Unit>> get revokes;/// Changes with each local change worth backing up.
 int get changeRevision;
/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitesStateCopyWith<InvitesState> get copyWith => _$InvitesStateCopyWithImpl<InvitesState>(this as InvitesState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesState'))
    ..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('siteId', siteId))..add(DiagnosticsProperty('invites', invites))..add(DiagnosticsProperty('loaded', loaded))..add(DiagnosticsProperty('refresh', refresh))..add(DiagnosticsProperty('requests', requests))..add(DiagnosticsProperty('revokes', revokes))..add(DiagnosticsProperty('changeRevision', changeRevision));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesState&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&const DeepCollectionEquality().equals(other.invites, invites)&&(identical(other.loaded, loaded) || other.loaded == loaded)&&(identical(other.refresh, refresh) || other.refresh == refresh)&&const DeepCollectionEquality().equals(other.requests, requests)&&const DeepCollectionEquality().equals(other.revokes, revokes)&&(identical(other.changeRevision, changeRevision) || other.changeRevision == changeRevision));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,siteId,const DeepCollectionEquality().hash(invites),loaded,refresh,const DeepCollectionEquality().hash(requests),const DeepCollectionEquality().hash(revokes),changeRevision);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesState(accountId: $accountId, siteId: $siteId, invites: $invites, loaded: $loaded, refresh: $refresh, requests: $requests, revokes: $revokes, changeRevision: $changeRevision)';
}


}

/// @nodoc
abstract mixin class $InvitesStateCopyWith<$Res>  {
  factory $InvitesStateCopyWith(InvitesState value, $Res Function(InvitesState) _then) = _$InvitesStateCopyWithImpl;
@useResult
$Res call({
 String? accountId, String? siteId, List<Invite> invites, bool loaded, RequestStatus<Unit>? refresh, Map<String, RequestStatus<Invite>> requests, Map<String, RequestStatus<Unit>> revokes, int changeRevision
});


$RequestStatusCopyWith<Unit, $Res>? get refresh;

}
/// @nodoc
class _$InvitesStateCopyWithImpl<$Res>
    implements $InvitesStateCopyWith<$Res> {
  _$InvitesStateCopyWithImpl(this._self, this._then);

  final InvitesState _self;
  final $Res Function(InvitesState) _then;

/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = freezed,Object? siteId = freezed,Object? invites = null,Object? loaded = null,Object? refresh = freezed,Object? requests = null,Object? revokes = null,Object? changeRevision = null,}) {
  return _then(_self.copyWith(
accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String?,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<Invite>,loaded: null == loaded ? _self.loaded : loaded // ignore: cast_nullable_to_non_nullable
as bool,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as RequestStatus<Unit>?,requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as Map<String, RequestStatus<Invite>>,revokes: null == revokes ? _self.revokes : revokes // ignore: cast_nullable_to_non_nullable
as Map<String, RequestStatus<Unit>>,changeRevision: null == changeRevision ? _self.changeRevision : changeRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of InvitesState
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


/// Adds pattern-matching-related methods to [InvitesState].
extension InvitesStatePatterns on InvitesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitesState value)  $default,){
final _that = this;
switch (_that) {
case _InvitesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitesState value)?  $default,){
final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accountId,  String? siteId,  List<Invite> invites,  bool loaded,  RequestStatus<Unit>? refresh,  Map<String, RequestStatus<Invite>> requests,  Map<String, RequestStatus<Unit>> revokes,  int changeRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
return $default(_that.accountId,_that.siteId,_that.invites,_that.loaded,_that.refresh,_that.requests,_that.revokes,_that.changeRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accountId,  String? siteId,  List<Invite> invites,  bool loaded,  RequestStatus<Unit>? refresh,  Map<String, RequestStatus<Invite>> requests,  Map<String, RequestStatus<Unit>> revokes,  int changeRevision)  $default,) {final _that = this;
switch (_that) {
case _InvitesState():
return $default(_that.accountId,_that.siteId,_that.invites,_that.loaded,_that.refresh,_that.requests,_that.revokes,_that.changeRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accountId,  String? siteId,  List<Invite> invites,  bool loaded,  RequestStatus<Unit>? refresh,  Map<String, RequestStatus<Invite>> requests,  Map<String, RequestStatus<Unit>> revokes,  int changeRevision)?  $default,) {final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
return $default(_that.accountId,_that.siteId,_that.invites,_that.loaded,_that.refresh,_that.requests,_that.revokes,_that.changeRevision);case _:
  return null;

}
}

}

/// @nodoc


class _InvitesState extends InvitesState with DiagnosticableTreeMixin {
  const _InvitesState({this.accountId, this.siteId, final  List<Invite> invites = const [], this.loaded = false, this.refresh, final  Map<String, RequestStatus<Invite>> requests = const {}, final  Map<String, RequestStatus<Unit>> revokes = const {}, this.changeRevision = 0}): _invites = invites,_requests = requests,_revokes = revokes,super._();
  

/// The estate account the invites belong to; null when signed out.
@override final  String? accountId;
@override final  String? siteId;
 final  List<Invite> _invites;
@override@JsonKey() List<Invite> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}

/// The archive has been read.
@override@JsonKey() final  bool loaded;
/// The latest fetch from ATG.
@override final  RequestStatus<Unit>? refresh;
/// Creates, by the request id their event carried.
 final  Map<String, RequestStatus<Invite>> _requests;
/// Creates, by the request id their event carried.
@override@JsonKey() Map<String, RequestStatus<Invite>> get requests {
  if (_requests is EqualUnmodifiableMapView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requests);
}

/// Revokes, by the request id their event carried.
 final  Map<String, RequestStatus<Unit>> _revokes;
/// Revokes, by the request id their event carried.
@override@JsonKey() Map<String, RequestStatus<Unit>> get revokes {
  if (_revokes is EqualUnmodifiableMapView) return _revokes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_revokes);
}

/// Changes with each local change worth backing up.
@override@JsonKey() final  int changeRevision;

/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitesStateCopyWith<_InvitesState> get copyWith => __$InvitesStateCopyWithImpl<_InvitesState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InvitesState'))
    ..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('siteId', siteId))..add(DiagnosticsProperty('invites', invites))..add(DiagnosticsProperty('loaded', loaded))..add(DiagnosticsProperty('refresh', refresh))..add(DiagnosticsProperty('requests', requests))..add(DiagnosticsProperty('revokes', revokes))..add(DiagnosticsProperty('changeRevision', changeRevision));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitesState&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&const DeepCollectionEquality().equals(other._invites, _invites)&&(identical(other.loaded, loaded) || other.loaded == loaded)&&(identical(other.refresh, refresh) || other.refresh == refresh)&&const DeepCollectionEquality().equals(other._requests, _requests)&&const DeepCollectionEquality().equals(other._revokes, _revokes)&&(identical(other.changeRevision, changeRevision) || other.changeRevision == changeRevision));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,siteId,const DeepCollectionEquality().hash(_invites),loaded,refresh,const DeepCollectionEquality().hash(_requests),const DeepCollectionEquality().hash(_revokes),changeRevision);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InvitesState(accountId: $accountId, siteId: $siteId, invites: $invites, loaded: $loaded, refresh: $refresh, requests: $requests, revokes: $revokes, changeRevision: $changeRevision)';
}


}

/// @nodoc
abstract mixin class _$InvitesStateCopyWith<$Res> implements $InvitesStateCopyWith<$Res> {
  factory _$InvitesStateCopyWith(_InvitesState value, $Res Function(_InvitesState) _then) = __$InvitesStateCopyWithImpl;
@override @useResult
$Res call({
 String? accountId, String? siteId, List<Invite> invites, bool loaded, RequestStatus<Unit>? refresh, Map<String, RequestStatus<Invite>> requests, Map<String, RequestStatus<Unit>> revokes, int changeRevision
});


@override $RequestStatusCopyWith<Unit, $Res>? get refresh;

}
/// @nodoc
class __$InvitesStateCopyWithImpl<$Res>
    implements _$InvitesStateCopyWith<$Res> {
  __$InvitesStateCopyWithImpl(this._self, this._then);

  final _InvitesState _self;
  final $Res Function(_InvitesState) _then;

/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = freezed,Object? siteId = freezed,Object? invites = null,Object? loaded = null,Object? refresh = freezed,Object? requests = null,Object? revokes = null,Object? changeRevision = null,}) {
  return _then(_InvitesState(
accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String?,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<Invite>,loaded: null == loaded ? _self.loaded : loaded // ignore: cast_nullable_to_non_nullable
as bool,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as RequestStatus<Unit>?,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as Map<String, RequestStatus<Invite>>,revokes: null == revokes ? _self._revokes : revokes // ignore: cast_nullable_to_non_nullable
as Map<String, RequestStatus<Unit>>,changeRevision: null == changeRevision ? _self.changeRevision : changeRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of InvitesState
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
