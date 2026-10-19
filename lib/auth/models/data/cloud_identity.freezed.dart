// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CloudIdentity {

 String get uid; String get idToken;
/// Create a copy of CloudIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloudIdentityCopyWith<CloudIdentity> get copyWith => _$CloudIdentityCopyWithImpl<CloudIdentity>(this as CloudIdentity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloudIdentity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.idToken, idToken) || other.idToken == idToken));
}


@override
int get hashCode => Object.hash(runtimeType,uid,idToken);

@override
String toString() {
  return 'CloudIdentity(uid: $uid, idToken: $idToken)';
}


}

/// @nodoc
abstract mixin class $CloudIdentityCopyWith<$Res>  {
  factory $CloudIdentityCopyWith(CloudIdentity value, $Res Function(CloudIdentity) _then) = _$CloudIdentityCopyWithImpl;
@useResult
$Res call({
 String uid, String idToken
});




}
/// @nodoc
class _$CloudIdentityCopyWithImpl<$Res>
    implements $CloudIdentityCopyWith<$Res> {
  _$CloudIdentityCopyWithImpl(this._self, this._then);

  final CloudIdentity _self;
  final $Res Function(CloudIdentity) _then;

/// Create a copy of CloudIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? idToken = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CloudIdentity].
extension CloudIdentityPatterns on CloudIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloudIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloudIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloudIdentity value)  $default,){
final _that = this;
switch (_that) {
case _CloudIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloudIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _CloudIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String idToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloudIdentity() when $default != null:
return $default(_that.uid,_that.idToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String idToken)  $default,) {final _that = this;
switch (_that) {
case _CloudIdentity():
return $default(_that.uid,_that.idToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String idToken)?  $default,) {final _that = this;
switch (_that) {
case _CloudIdentity() when $default != null:
return $default(_that.uid,_that.idToken);case _:
  return null;

}
}

}

/// @nodoc


class _CloudIdentity implements CloudIdentity {
  const _CloudIdentity({required this.uid, required this.idToken});
  

@override final  String uid;
@override final  String idToken;

/// Create a copy of CloudIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloudIdentityCopyWith<_CloudIdentity> get copyWith => __$CloudIdentityCopyWithImpl<_CloudIdentity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloudIdentity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.idToken, idToken) || other.idToken == idToken));
}


@override
int get hashCode => Object.hash(runtimeType,uid,idToken);

@override
String toString() {
  return 'CloudIdentity(uid: $uid, idToken: $idToken)';
}


}

/// @nodoc
abstract mixin class _$CloudIdentityCopyWith<$Res> implements $CloudIdentityCopyWith<$Res> {
  factory _$CloudIdentityCopyWith(_CloudIdentity value, $Res Function(_CloudIdentity) _then) = __$CloudIdentityCopyWithImpl;
@override @useResult
$Res call({
 String uid, String idToken
});




}
/// @nodoc
class __$CloudIdentityCopyWithImpl<$Res>
    implements _$CloudIdentityCopyWith<$Res> {
  __$CloudIdentityCopyWithImpl(this._self, this._then);

  final _CloudIdentity _self;
  final $Res Function(_CloudIdentity) _then;

/// Create a copy of CloudIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? idToken = null,}) {
  return _then(_CloudIdentity(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
