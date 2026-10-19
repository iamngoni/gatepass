// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInEvent()';
}


}

/// @nodoc
class $SignInEventCopyWith<$Res>  {
$SignInEventCopyWith(SignInEvent _, $Res Function(SignInEvent) __);
}


/// Adds pattern-matching-related methods to [SignInEvent].
extension SignInEventPatterns on SignInEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignInCodeRequestedEvent value)?  codeRequested,TResult Function( SignInCodeSubmittedEvent value)?  codeSubmitted,TResult Function( SignInNumberChangeRequestedEvent value)?  numberChangeRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignInCodeRequestedEvent() when codeRequested != null:
return codeRequested(_that);case SignInCodeSubmittedEvent() when codeSubmitted != null:
return codeSubmitted(_that);case SignInNumberChangeRequestedEvent() when numberChangeRequested != null:
return numberChangeRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignInCodeRequestedEvent value)  codeRequested,required TResult Function( SignInCodeSubmittedEvent value)  codeSubmitted,required TResult Function( SignInNumberChangeRequestedEvent value)  numberChangeRequested,}){
final _that = this;
switch (_that) {
case SignInCodeRequestedEvent():
return codeRequested(_that);case SignInCodeSubmittedEvent():
return codeSubmitted(_that);case SignInNumberChangeRequestedEvent():
return numberChangeRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignInCodeRequestedEvent value)?  codeRequested,TResult? Function( SignInCodeSubmittedEvent value)?  codeSubmitted,TResult? Function( SignInNumberChangeRequestedEvent value)?  numberChangeRequested,}){
final _that = this;
switch (_that) {
case SignInCodeRequestedEvent() when codeRequested != null:
return codeRequested(_that);case SignInCodeSubmittedEvent() when codeSubmitted != null:
return codeSubmitted(_that);case SignInNumberChangeRequestedEvent() when numberChangeRequested != null:
return numberChangeRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String phone,  OtpChannel channel)?  codeRequested,TResult Function( String phone,  String code)?  codeSubmitted,TResult Function()?  numberChangeRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignInCodeRequestedEvent() when codeRequested != null:
return codeRequested(_that.phone,_that.channel);case SignInCodeSubmittedEvent() when codeSubmitted != null:
return codeSubmitted(_that.phone,_that.code);case SignInNumberChangeRequestedEvent() when numberChangeRequested != null:
return numberChangeRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String phone,  OtpChannel channel)  codeRequested,required TResult Function( String phone,  String code)  codeSubmitted,required TResult Function()  numberChangeRequested,}) {final _that = this;
switch (_that) {
case SignInCodeRequestedEvent():
return codeRequested(_that.phone,_that.channel);case SignInCodeSubmittedEvent():
return codeSubmitted(_that.phone,_that.code);case SignInNumberChangeRequestedEvent():
return numberChangeRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String phone,  OtpChannel channel)?  codeRequested,TResult? Function( String phone,  String code)?  codeSubmitted,TResult? Function()?  numberChangeRequested,}) {final _that = this;
switch (_that) {
case SignInCodeRequestedEvent() when codeRequested != null:
return codeRequested(_that.phone,_that.channel);case SignInCodeSubmittedEvent() when codeSubmitted != null:
return codeSubmitted(_that.phone,_that.code);case SignInNumberChangeRequestedEvent() when numberChangeRequested != null:
return numberChangeRequested();case _:
  return null;

}
}

}

/// @nodoc


class SignInCodeRequestedEvent implements SignInEvent {
  const SignInCodeRequestedEvent({required this.phone, required this.channel});
  

 final  String phone;
 final  OtpChannel channel;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInCodeRequestedEventCopyWith<SignInCodeRequestedEvent> get copyWith => _$SignInCodeRequestedEventCopyWithImpl<SignInCodeRequestedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInCodeRequestedEvent&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.channel, channel) || other.channel == channel));
}


@override
int get hashCode => Object.hash(runtimeType,phone,channel);

@override
String toString() {
  return 'SignInEvent.codeRequested(phone: $phone, channel: $channel)';
}


}

/// @nodoc
abstract mixin class $SignInCodeRequestedEventCopyWith<$Res> implements $SignInEventCopyWith<$Res> {
  factory $SignInCodeRequestedEventCopyWith(SignInCodeRequestedEvent value, $Res Function(SignInCodeRequestedEvent) _then) = _$SignInCodeRequestedEventCopyWithImpl;
@useResult
$Res call({
 String phone, OtpChannel channel
});




}
/// @nodoc
class _$SignInCodeRequestedEventCopyWithImpl<$Res>
    implements $SignInCodeRequestedEventCopyWith<$Res> {
  _$SignInCodeRequestedEventCopyWithImpl(this._self, this._then);

  final SignInCodeRequestedEvent _self;
  final $Res Function(SignInCodeRequestedEvent) _then;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? channel = null,}) {
  return _then(SignInCodeRequestedEvent(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as OtpChannel,
  ));
}


}

/// @nodoc


class SignInCodeSubmittedEvent implements SignInEvent {
  const SignInCodeSubmittedEvent({required this.phone, required this.code});
  

 final  String phone;
 final  String code;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInCodeSubmittedEventCopyWith<SignInCodeSubmittedEvent> get copyWith => _$SignInCodeSubmittedEventCopyWithImpl<SignInCodeSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInCodeSubmittedEvent&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'SignInEvent.codeSubmitted(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class $SignInCodeSubmittedEventCopyWith<$Res> implements $SignInEventCopyWith<$Res> {
  factory $SignInCodeSubmittedEventCopyWith(SignInCodeSubmittedEvent value, $Res Function(SignInCodeSubmittedEvent) _then) = _$SignInCodeSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class _$SignInCodeSubmittedEventCopyWithImpl<$Res>
    implements $SignInCodeSubmittedEventCopyWith<$Res> {
  _$SignInCodeSubmittedEventCopyWithImpl(this._self, this._then);

  final SignInCodeSubmittedEvent _self;
  final $Res Function(SignInCodeSubmittedEvent) _then;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? code = null,}) {
  return _then(SignInCodeSubmittedEvent(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignInNumberChangeRequestedEvent implements SignInEvent {
  const SignInNumberChangeRequestedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInNumberChangeRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInEvent.numberChangeRequested()';
}


}




/// @nodoc
mixin _$SignInState {

/// On the code step.
 bool get codeSent;/// The way the last code went, so a resend goes the same way.
 OtpChannel get channel;/// The way a code is being sent right now, for its button's spinner.
 OtpChannel? get sending; bool get verifying;/// Set once the code is accepted.
 AccountSession? get account;/// The latest failure. [errorRevision] changes with each one, so the
/// same error twice still shows twice.
 ApplicationError? get error; int get errorRevision;
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInStateCopyWith<SignInState> get copyWith => _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState&&(identical(other.codeSent, codeSent) || other.codeSent == codeSent)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.verifying, verifying) || other.verifying == verifying)&&(identical(other.account, account) || other.account == account)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorRevision, errorRevision) || other.errorRevision == errorRevision));
}


@override
int get hashCode => Object.hash(runtimeType,codeSent,channel,sending,verifying,account,error,errorRevision);

@override
String toString() {
  return 'SignInState(codeSent: $codeSent, channel: $channel, sending: $sending, verifying: $verifying, account: $account, error: $error, errorRevision: $errorRevision)';
}


}

/// @nodoc
abstract mixin class $SignInStateCopyWith<$Res>  {
  factory $SignInStateCopyWith(SignInState value, $Res Function(SignInState) _then) = _$SignInStateCopyWithImpl;
@useResult
$Res call({
 bool codeSent, OtpChannel channel, OtpChannel? sending, bool verifying, AccountSession? account, ApplicationError? error, int errorRevision
});


$AccountSessionCopyWith<$Res>? get account;$ApplicationErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$SignInStateCopyWithImpl<$Res>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._self, this._then);

  final SignInState _self;
  final $Res Function(SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? codeSent = null,Object? channel = null,Object? sending = freezed,Object? verifying = null,Object? account = freezed,Object? error = freezed,Object? errorRevision = null,}) {
  return _then(_self.copyWith(
codeSent: null == codeSent ? _self.codeSent : codeSent // ignore: cast_nullable_to_non_nullable
as bool,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as OtpChannel,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as OtpChannel?,verifying: null == verifying ? _self.verifying : verifying // ignore: cast_nullable_to_non_nullable
as bool,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountSession?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApplicationError?,errorRevision: null == errorRevision ? _self.errorRevision : errorRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountSessionCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $AccountSessionCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApplicationErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInState value)  $default,){
final _that = this;
switch (_that) {
case _SignInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool codeSent,  OtpChannel channel,  OtpChannel? sending,  bool verifying,  AccountSession? account,  ApplicationError? error,  int errorRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.codeSent,_that.channel,_that.sending,_that.verifying,_that.account,_that.error,_that.errorRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool codeSent,  OtpChannel channel,  OtpChannel? sending,  bool verifying,  AccountSession? account,  ApplicationError? error,  int errorRevision)  $default,) {final _that = this;
switch (_that) {
case _SignInState():
return $default(_that.codeSent,_that.channel,_that.sending,_that.verifying,_that.account,_that.error,_that.errorRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool codeSent,  OtpChannel channel,  OtpChannel? sending,  bool verifying,  AccountSession? account,  ApplicationError? error,  int errorRevision)?  $default,) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.codeSent,_that.channel,_that.sending,_that.verifying,_that.account,_that.error,_that.errorRevision);case _:
  return null;

}
}

}

/// @nodoc


class _SignInState extends SignInState {
  const _SignInState({this.codeSent = false, this.channel = OtpChannel.sms, this.sending, this.verifying = false, this.account, this.error, this.errorRevision = 0}): super._();
  

/// On the code step.
@override@JsonKey() final  bool codeSent;
/// The way the last code went, so a resend goes the same way.
@override@JsonKey() final  OtpChannel channel;
/// The way a code is being sent right now, for its button's spinner.
@override final  OtpChannel? sending;
@override@JsonKey() final  bool verifying;
/// Set once the code is accepted.
@override final  AccountSession? account;
/// The latest failure. [errorRevision] changes with each one, so the
/// same error twice still shows twice.
@override final  ApplicationError? error;
@override@JsonKey() final  int errorRevision;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInStateCopyWith<_SignInState> get copyWith => __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInState&&(identical(other.codeSent, codeSent) || other.codeSent == codeSent)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.verifying, verifying) || other.verifying == verifying)&&(identical(other.account, account) || other.account == account)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorRevision, errorRevision) || other.errorRevision == errorRevision));
}


@override
int get hashCode => Object.hash(runtimeType,codeSent,channel,sending,verifying,account,error,errorRevision);

@override
String toString() {
  return 'SignInState(codeSent: $codeSent, channel: $channel, sending: $sending, verifying: $verifying, account: $account, error: $error, errorRevision: $errorRevision)';
}


}

/// @nodoc
abstract mixin class _$SignInStateCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(_SignInState value, $Res Function(_SignInState) _then) = __$SignInStateCopyWithImpl;
@override @useResult
$Res call({
 bool codeSent, OtpChannel channel, OtpChannel? sending, bool verifying, AccountSession? account, ApplicationError? error, int errorRevision
});


@override $AccountSessionCopyWith<$Res>? get account;@override $ApplicationErrorCopyWith<$Res>? get error;

}
/// @nodoc
class __$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(this._self, this._then);

  final _SignInState _self;
  final $Res Function(_SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codeSent = null,Object? channel = null,Object? sending = freezed,Object? verifying = null,Object? account = freezed,Object? error = freezed,Object? errorRevision = null,}) {
  return _then(_SignInState(
codeSent: null == codeSent ? _self.codeSent : codeSent // ignore: cast_nullable_to_non_nullable
as bool,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as OtpChannel,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as OtpChannel?,verifying: null == verifying ? _self.verifying : verifying // ignore: cast_nullable_to_non_nullable
as bool,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountSession?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApplicationError?,errorRevision: null == errorRevision ? _self.errorRevision : errorRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountSessionCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $AccountSessionCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApplicationErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
