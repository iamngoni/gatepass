// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountSession {

 Resident get resident; Site get site;
/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSessionCopyWith<AccountSession> get copyWith => _$AccountSessionCopyWithImpl<AccountSession>(this as AccountSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSession&&(identical(other.resident, resident) || other.resident == resident)&&(identical(other.site, site) || other.site == site));
}


@override
int get hashCode => Object.hash(runtimeType,resident,site);

@override
String toString() {
  return 'AccountSession(resident: $resident, site: $site)';
}


}

/// @nodoc
abstract mixin class $AccountSessionCopyWith<$Res>  {
  factory $AccountSessionCopyWith(AccountSession value, $Res Function(AccountSession) _then) = _$AccountSessionCopyWithImpl;
@useResult
$Res call({
 Resident resident, Site site
});


$ResidentCopyWith<$Res> get resident;$SiteCopyWith<$Res> get site;

}
/// @nodoc
class _$AccountSessionCopyWithImpl<$Res>
    implements $AccountSessionCopyWith<$Res> {
  _$AccountSessionCopyWithImpl(this._self, this._then);

  final AccountSession _self;
  final $Res Function(AccountSession) _then;

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resident = null,Object? site = null,}) {
  return _then(_self.copyWith(
resident: null == resident ? _self.resident : resident // ignore: cast_nullable_to_non_nullable
as Resident,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as Site,
  ));
}
/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResidentCopyWith<$Res> get resident {
  
  return $ResidentCopyWith<$Res>(_self.resident, (value) {
    return _then(_self.copyWith(resident: value));
  });
}/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SiteCopyWith<$Res> get site {
  
  return $SiteCopyWith<$Res>(_self.site, (value) {
    return _then(_self.copyWith(site: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountSession].
extension AccountSessionPatterns on AccountSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountSession value)  $default,){
final _that = this;
switch (_that) {
case _AccountSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountSession value)?  $default,){
final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Resident resident,  Site site)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
return $default(_that.resident,_that.site);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Resident resident,  Site site)  $default,) {final _that = this;
switch (_that) {
case _AccountSession():
return $default(_that.resident,_that.site);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Resident resident,  Site site)?  $default,) {final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
return $default(_that.resident,_that.site);case _:
  return null;

}
}

}

/// @nodoc


class _AccountSession implements AccountSession {
  const _AccountSession({required this.resident, required this.site});
  

@override final  Resident resident;
@override final  Site site;

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSessionCopyWith<_AccountSession> get copyWith => __$AccountSessionCopyWithImpl<_AccountSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSession&&(identical(other.resident, resident) || other.resident == resident)&&(identical(other.site, site) || other.site == site));
}


@override
int get hashCode => Object.hash(runtimeType,resident,site);

@override
String toString() {
  return 'AccountSession(resident: $resident, site: $site)';
}


}

/// @nodoc
abstract mixin class _$AccountSessionCopyWith<$Res> implements $AccountSessionCopyWith<$Res> {
  factory _$AccountSessionCopyWith(_AccountSession value, $Res Function(_AccountSession) _then) = __$AccountSessionCopyWithImpl;
@override @useResult
$Res call({
 Resident resident, Site site
});


@override $ResidentCopyWith<$Res> get resident;@override $SiteCopyWith<$Res> get site;

}
/// @nodoc
class __$AccountSessionCopyWithImpl<$Res>
    implements _$AccountSessionCopyWith<$Res> {
  __$AccountSessionCopyWithImpl(this._self, this._then);

  final _AccountSession _self;
  final $Res Function(_AccountSession) _then;

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resident = null,Object? site = null,}) {
  return _then(_AccountSession(
resident: null == resident ? _self.resident : resident // ignore: cast_nullable_to_non_nullable
as Resident,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as Site,
  ));
}

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResidentCopyWith<$Res> get resident {
  
  return $ResidentCopyWith<$Res>(_self.resident, (value) {
    return _then(_self.copyWith(resident: value));
  });
}/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SiteCopyWith<$Res> get site {
  
  return $SiteCopyWith<$Res>(_self.site, (value) {
    return _then(_self.copyWith(site: value));
  });
}
}

// dart format on
