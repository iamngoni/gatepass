// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_form_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InviteFormData {

/// Midnight of the chosen day.
 DateTime get date;/// Arrival time for a set number of hours, in minutes since midnight.
 int get start; InviteDay get day; InviteStay get stay; bool get byCar;/// The day, hours, mobile number and car. Closed by default, so the
/// usual invite is a name and nothing else.
 bool get advanced; bool get saving;
/// Create a copy of InviteFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteFormDataCopyWith<InviteFormData> get copyWith => _$InviteFormDataCopyWithImpl<InviteFormData>(this as InviteFormData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteFormData&&(identical(other.date, date) || other.date == date)&&(identical(other.start, start) || other.start == start)&&(identical(other.day, day) || other.day == day)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.byCar, byCar) || other.byCar == byCar)&&(identical(other.advanced, advanced) || other.advanced == advanced)&&(identical(other.saving, saving) || other.saving == saving));
}


@override
int get hashCode => Object.hash(runtimeType,date,start,day,stay,byCar,advanced,saving);

@override
String toString() {
  return 'InviteFormData(date: $date, start: $start, day: $day, stay: $stay, byCar: $byCar, advanced: $advanced, saving: $saving)';
}


}

/// @nodoc
abstract mixin class $InviteFormDataCopyWith<$Res>  {
  factory $InviteFormDataCopyWith(InviteFormData value, $Res Function(InviteFormData) _then) = _$InviteFormDataCopyWithImpl;
@useResult
$Res call({
 DateTime date, int start, InviteDay day, InviteStay stay, bool byCar, bool advanced, bool saving
});




}
/// @nodoc
class _$InviteFormDataCopyWithImpl<$Res>
    implements $InviteFormDataCopyWith<$Res> {
  _$InviteFormDataCopyWithImpl(this._self, this._then);

  final InviteFormData _self;
  final $Res Function(InviteFormData) _then;

/// Create a copy of InviteFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? start = null,Object? day = null,Object? stay = null,Object? byCar = null,Object? advanced = null,Object? saving = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as InviteDay,stay: null == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as InviteStay,byCar: null == byCar ? _self.byCar : byCar // ignore: cast_nullable_to_non_nullable
as bool,advanced: null == advanced ? _self.advanced : advanced // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteFormData].
extension InviteFormDataPatterns on InviteFormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteFormData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteFormData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteFormData value)  $default,){
final _that = this;
switch (_that) {
case _InviteFormData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteFormData value)?  $default,){
final _that = this;
switch (_that) {
case _InviteFormData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int start,  InviteDay day,  InviteStay stay,  bool byCar,  bool advanced,  bool saving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteFormData() when $default != null:
return $default(_that.date,_that.start,_that.day,_that.stay,_that.byCar,_that.advanced,_that.saving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int start,  InviteDay day,  InviteStay stay,  bool byCar,  bool advanced,  bool saving)  $default,) {final _that = this;
switch (_that) {
case _InviteFormData():
return $default(_that.date,_that.start,_that.day,_that.stay,_that.byCar,_that.advanced,_that.saving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int start,  InviteDay day,  InviteStay stay,  bool byCar,  bool advanced,  bool saving)?  $default,) {final _that = this;
switch (_that) {
case _InviteFormData() when $default != null:
return $default(_that.date,_that.start,_that.day,_that.stay,_that.byCar,_that.advanced,_that.saving);case _:
  return null;

}
}

}

/// @nodoc


class _InviteFormData extends InviteFormData {
  const _InviteFormData({required this.date, required this.start, this.day = InviteDay.today, this.stay = InviteStay.allDay, this.byCar = false, this.advanced = false, this.saving = false}): super._();
  

/// Midnight of the chosen day.
@override final  DateTime date;
/// Arrival time for a set number of hours, in minutes since midnight.
@override final  int start;
@override@JsonKey() final  InviteDay day;
@override@JsonKey() final  InviteStay stay;
@override@JsonKey() final  bool byCar;
/// The day, hours, mobile number and car. Closed by default, so the
/// usual invite is a name and nothing else.
@override@JsonKey() final  bool advanced;
@override@JsonKey() final  bool saving;

/// Create a copy of InviteFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteFormDataCopyWith<_InviteFormData> get copyWith => __$InviteFormDataCopyWithImpl<_InviteFormData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteFormData&&(identical(other.date, date) || other.date == date)&&(identical(other.start, start) || other.start == start)&&(identical(other.day, day) || other.day == day)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.byCar, byCar) || other.byCar == byCar)&&(identical(other.advanced, advanced) || other.advanced == advanced)&&(identical(other.saving, saving) || other.saving == saving));
}


@override
int get hashCode => Object.hash(runtimeType,date,start,day,stay,byCar,advanced,saving);

@override
String toString() {
  return 'InviteFormData(date: $date, start: $start, day: $day, stay: $stay, byCar: $byCar, advanced: $advanced, saving: $saving)';
}


}

/// @nodoc
abstract mixin class _$InviteFormDataCopyWith<$Res> implements $InviteFormDataCopyWith<$Res> {
  factory _$InviteFormDataCopyWith(_InviteFormData value, $Res Function(_InviteFormData) _then) = __$InviteFormDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int start, InviteDay day, InviteStay stay, bool byCar, bool advanced, bool saving
});




}
/// @nodoc
class __$InviteFormDataCopyWithImpl<$Res>
    implements _$InviteFormDataCopyWith<$Res> {
  __$InviteFormDataCopyWithImpl(this._self, this._then);

  final _InviteFormData _self;
  final $Res Function(_InviteFormData) _then;

/// Create a copy of InviteFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? start = null,Object? day = null,Object? stay = null,Object? byCar = null,Object? advanced = null,Object? saving = null,}) {
  return _then(_InviteFormData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as InviteDay,stay: null == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as InviteStay,byCar: null == byCar ? _self.byCar : byCar // ignore: cast_nullable_to_non_nullable
as bool,advanced: null == advanced ? _self.advanced : advanced // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
