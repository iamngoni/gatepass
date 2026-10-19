// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sealed_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SealedBackupDTO {

 int get v; BackupKdfDTO get kdf;/// Base64.
 String get nonce;/// Base64 ciphertext with the 16-byte tag appended.
 String get ct;
/// Create a copy of SealedBackupDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SealedBackupDTOCopyWith<SealedBackupDTO> get copyWith => _$SealedBackupDTOCopyWithImpl<SealedBackupDTO>(this as SealedBackupDTO, _$identity);

  /// Serializes this SealedBackupDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SealedBackupDTO&&(identical(other.v, v) || other.v == v)&&(identical(other.kdf, kdf) || other.kdf == kdf)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.ct, ct) || other.ct == ct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,v,kdf,nonce,ct);

@override
String toString() {
  return 'SealedBackupDTO(v: $v, kdf: $kdf, nonce: $nonce, ct: $ct)';
}


}

/// @nodoc
abstract mixin class $SealedBackupDTOCopyWith<$Res>  {
  factory $SealedBackupDTOCopyWith(SealedBackupDTO value, $Res Function(SealedBackupDTO) _then) = _$SealedBackupDTOCopyWithImpl;
@useResult
$Res call({
 int v, BackupKdfDTO kdf, String nonce, String ct
});


$BackupKdfDTOCopyWith<$Res> get kdf;

}
/// @nodoc
class _$SealedBackupDTOCopyWithImpl<$Res>
    implements $SealedBackupDTOCopyWith<$Res> {
  _$SealedBackupDTOCopyWithImpl(this._self, this._then);

  final SealedBackupDTO _self;
  final $Res Function(SealedBackupDTO) _then;

/// Create a copy of SealedBackupDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? v = null,Object? kdf = null,Object? nonce = null,Object? ct = null,}) {
  return _then(_self.copyWith(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,kdf: null == kdf ? _self.kdf : kdf // ignore: cast_nullable_to_non_nullable
as BackupKdfDTO,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,ct: null == ct ? _self.ct : ct // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SealedBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupKdfDTOCopyWith<$Res> get kdf {
  
  return $BackupKdfDTOCopyWith<$Res>(_self.kdf, (value) {
    return _then(_self.copyWith(kdf: value));
  });
}
}


/// Adds pattern-matching-related methods to [SealedBackupDTO].
extension SealedBackupDTOPatterns on SealedBackupDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SealedBackupDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SealedBackupDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SealedBackupDTO value)  $default,){
final _that = this;
switch (_that) {
case _SealedBackupDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SealedBackupDTO value)?  $default,){
final _that = this;
switch (_that) {
case _SealedBackupDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int v,  BackupKdfDTO kdf,  String nonce,  String ct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SealedBackupDTO() when $default != null:
return $default(_that.v,_that.kdf,_that.nonce,_that.ct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int v,  BackupKdfDTO kdf,  String nonce,  String ct)  $default,) {final _that = this;
switch (_that) {
case _SealedBackupDTO():
return $default(_that.v,_that.kdf,_that.nonce,_that.ct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int v,  BackupKdfDTO kdf,  String nonce,  String ct)?  $default,) {final _that = this;
switch (_that) {
case _SealedBackupDTO() when $default != null:
return $default(_that.v,_that.kdf,_that.nonce,_that.ct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SealedBackupDTO implements SealedBackupDTO {
  const _SealedBackupDTO({required this.v, required this.kdf, required this.nonce, required this.ct});
  factory _SealedBackupDTO.fromJson(Map<String, dynamic> json) => _$SealedBackupDTOFromJson(json);

@override final  int v;
@override final  BackupKdfDTO kdf;
/// Base64.
@override final  String nonce;
/// Base64 ciphertext with the 16-byte tag appended.
@override final  String ct;

/// Create a copy of SealedBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SealedBackupDTOCopyWith<_SealedBackupDTO> get copyWith => __$SealedBackupDTOCopyWithImpl<_SealedBackupDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SealedBackupDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SealedBackupDTO&&(identical(other.v, v) || other.v == v)&&(identical(other.kdf, kdf) || other.kdf == kdf)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.ct, ct) || other.ct == ct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,v,kdf,nonce,ct);

@override
String toString() {
  return 'SealedBackupDTO(v: $v, kdf: $kdf, nonce: $nonce, ct: $ct)';
}


}

/// @nodoc
abstract mixin class _$SealedBackupDTOCopyWith<$Res> implements $SealedBackupDTOCopyWith<$Res> {
  factory _$SealedBackupDTOCopyWith(_SealedBackupDTO value, $Res Function(_SealedBackupDTO) _then) = __$SealedBackupDTOCopyWithImpl;
@override @useResult
$Res call({
 int v, BackupKdfDTO kdf, String nonce, String ct
});


@override $BackupKdfDTOCopyWith<$Res> get kdf;

}
/// @nodoc
class __$SealedBackupDTOCopyWithImpl<$Res>
    implements _$SealedBackupDTOCopyWith<$Res> {
  __$SealedBackupDTOCopyWithImpl(this._self, this._then);

  final _SealedBackupDTO _self;
  final $Res Function(_SealedBackupDTO) _then;

/// Create a copy of SealedBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? v = null,Object? kdf = null,Object? nonce = null,Object? ct = null,}) {
  return _then(_SealedBackupDTO(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,kdf: null == kdf ? _self.kdf : kdf // ignore: cast_nullable_to_non_nullable
as BackupKdfDTO,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,ct: null == ct ? _self.ct : ct // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SealedBackupDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupKdfDTOCopyWith<$Res> get kdf {
  
  return $BackupKdfDTOCopyWith<$Res>(_self.kdf, (value) {
    return _then(_self.copyWith(kdf: value));
  });
}
}


/// @nodoc
mixin _$BackupKdfDTO {

/// Memory, KiB.
 int get m;/// Iterations.
 int get t;/// Base64.
 String get salt; String get alg;/// Lanes.
 int get p;
/// Create a copy of BackupKdfDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupKdfDTOCopyWith<BackupKdfDTO> get copyWith => _$BackupKdfDTOCopyWithImpl<BackupKdfDTO>(this as BackupKdfDTO, _$identity);

  /// Serializes this BackupKdfDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupKdfDTO&&(identical(other.m, m) || other.m == m)&&(identical(other.t, t) || other.t == t)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.alg, alg) || other.alg == alg)&&(identical(other.p, p) || other.p == p));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,m,t,salt,alg,p);

@override
String toString() {
  return 'BackupKdfDTO(m: $m, t: $t, salt: $salt, alg: $alg, p: $p)';
}


}

/// @nodoc
abstract mixin class $BackupKdfDTOCopyWith<$Res>  {
  factory $BackupKdfDTOCopyWith(BackupKdfDTO value, $Res Function(BackupKdfDTO) _then) = _$BackupKdfDTOCopyWithImpl;
@useResult
$Res call({
 int m, int t, String salt, String alg, int p
});




}
/// @nodoc
class _$BackupKdfDTOCopyWithImpl<$Res>
    implements $BackupKdfDTOCopyWith<$Res> {
  _$BackupKdfDTOCopyWithImpl(this._self, this._then);

  final BackupKdfDTO _self;
  final $Res Function(BackupKdfDTO) _then;

/// Create a copy of BackupKdfDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? m = null,Object? t = null,Object? salt = null,Object? alg = null,Object? p = null,}) {
  return _then(_self.copyWith(
m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as int,t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as int,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,alg: null == alg ? _self.alg : alg // ignore: cast_nullable_to_non_nullable
as String,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupKdfDTO].
extension BackupKdfDTOPatterns on BackupKdfDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupKdfDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupKdfDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupKdfDTO value)  $default,){
final _that = this;
switch (_that) {
case _BackupKdfDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupKdfDTO value)?  $default,){
final _that = this;
switch (_that) {
case _BackupKdfDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int m,  int t,  String salt,  String alg,  int p)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupKdfDTO() when $default != null:
return $default(_that.m,_that.t,_that.salt,_that.alg,_that.p);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int m,  int t,  String salt,  String alg,  int p)  $default,) {final _that = this;
switch (_that) {
case _BackupKdfDTO():
return $default(_that.m,_that.t,_that.salt,_that.alg,_that.p);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int m,  int t,  String salt,  String alg,  int p)?  $default,) {final _that = this;
switch (_that) {
case _BackupKdfDTO() when $default != null:
return $default(_that.m,_that.t,_that.salt,_that.alg,_that.p);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupKdfDTO implements BackupKdfDTO {
  const _BackupKdfDTO({required this.m, required this.t, required this.salt, this.alg = 'argon2id', this.p = 1});
  factory _BackupKdfDTO.fromJson(Map<String, dynamic> json) => _$BackupKdfDTOFromJson(json);

/// Memory, KiB.
@override final  int m;
/// Iterations.
@override final  int t;
/// Base64.
@override final  String salt;
@override@JsonKey() final  String alg;
/// Lanes.
@override@JsonKey() final  int p;

/// Create a copy of BackupKdfDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupKdfDTOCopyWith<_BackupKdfDTO> get copyWith => __$BackupKdfDTOCopyWithImpl<_BackupKdfDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupKdfDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupKdfDTO&&(identical(other.m, m) || other.m == m)&&(identical(other.t, t) || other.t == t)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.alg, alg) || other.alg == alg)&&(identical(other.p, p) || other.p == p));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,m,t,salt,alg,p);

@override
String toString() {
  return 'BackupKdfDTO(m: $m, t: $t, salt: $salt, alg: $alg, p: $p)';
}


}

/// @nodoc
abstract mixin class _$BackupKdfDTOCopyWith<$Res> implements $BackupKdfDTOCopyWith<$Res> {
  factory _$BackupKdfDTOCopyWith(_BackupKdfDTO value, $Res Function(_BackupKdfDTO) _then) = __$BackupKdfDTOCopyWithImpl;
@override @useResult
$Res call({
 int m, int t, String salt, String alg, int p
});




}
/// @nodoc
class __$BackupKdfDTOCopyWithImpl<$Res>
    implements _$BackupKdfDTOCopyWith<$Res> {
  __$BackupKdfDTOCopyWithImpl(this._self, this._then);

  final _BackupKdfDTO _self;
  final $Res Function(_BackupKdfDTO) _then;

/// Create a copy of BackupKdfDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? m = null,Object? t = null,Object? salt = null,Object? alg = null,Object? p = null,}) {
  return _then(_BackupKdfDTO(
m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as int,t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as int,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,alg: null == alg ? _self.alg : alg // ignore: cast_nullable_to_non_nullable
as String,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
