// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Visit {

@JsonKey(includeIfNull: false) int? get id;@JsonKey(name: 'customer_id') int get customerId;@JsonKey(name: 'visit_date') String get visitDate; String get status; String get location; String get notes;@JsonKey(name: 'activities_done', fromJson: _parseActivities) List<String> get activitiesDone;@JsonKey(name: 'created_at', includeIfNull: false) String? get createdAt;
/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitCopyWith<Visit> get copyWith => _$VisitCopyWithImpl<Visit>(this as Visit, _$identity);

  /// Serializes this Visit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Visit&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.activitiesDone, activitiesDone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,visitDate,status,location,notes,const DeepCollectionEquality().hash(activitiesDone),createdAt);

@override
String toString() {
  return 'Visit(id: $id, customerId: $customerId, visitDate: $visitDate, status: $status, location: $location, notes: $notes, activitiesDone: $activitiesDone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $VisitCopyWith<$Res>  {
  factory $VisitCopyWith(Visit value, $Res Function(Visit) _then) = _$VisitCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'customer_id') int customerId,@JsonKey(name: 'visit_date') String visitDate, String status, String location, String notes,@JsonKey(name: 'activities_done', fromJson: _parseActivities) List<String> activitiesDone,@JsonKey(name: 'created_at', includeIfNull: false) String? createdAt
});




}
/// @nodoc
class _$VisitCopyWithImpl<$Res>
    implements $VisitCopyWith<$Res> {
  _$VisitCopyWithImpl(this._self, this._then);

  final Visit _self;
  final $Res Function(Visit) _then;

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? customerId = null,Object? visitDate = null,Object? status = null,Object? location = null,Object? notes = null,Object? activitiesDone = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,activitiesDone: null == activitiesDone ? _self.activitiesDone : activitiesDone // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Visit implements Visit {
  const _Visit({@JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'customer_id') required this.customerId, @JsonKey(name: 'visit_date') required this.visitDate, required this.status, required this.location, required this.notes, @JsonKey(name: 'activities_done', fromJson: _parseActivities) required final  List<String> activitiesDone, @JsonKey(name: 'created_at', includeIfNull: false) this.createdAt}): _activitiesDone = activitiesDone;
  factory _Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? id;
@override@JsonKey(name: 'customer_id') final  int customerId;
@override@JsonKey(name: 'visit_date') final  String visitDate;
@override final  String status;
@override final  String location;
@override final  String notes;
 final  List<String> _activitiesDone;
@override@JsonKey(name: 'activities_done', fromJson: _parseActivities) List<String> get activitiesDone {
  if (_activitiesDone is EqualUnmodifiableListView) return _activitiesDone;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activitiesDone);
}

@override@JsonKey(name: 'created_at', includeIfNull: false) final  String? createdAt;

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitCopyWith<_Visit> get copyWith => __$VisitCopyWithImpl<_Visit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Visit&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._activitiesDone, _activitiesDone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,visitDate,status,location,notes,const DeepCollectionEquality().hash(_activitiesDone),createdAt);

@override
String toString() {
  return 'Visit(id: $id, customerId: $customerId, visitDate: $visitDate, status: $status, location: $location, notes: $notes, activitiesDone: $activitiesDone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VisitCopyWith<$Res> implements $VisitCopyWith<$Res> {
  factory _$VisitCopyWith(_Visit value, $Res Function(_Visit) _then) = __$VisitCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'customer_id') int customerId,@JsonKey(name: 'visit_date') String visitDate, String status, String location, String notes,@JsonKey(name: 'activities_done', fromJson: _parseActivities) List<String> activitiesDone,@JsonKey(name: 'created_at', includeIfNull: false) String? createdAt
});




}
/// @nodoc
class __$VisitCopyWithImpl<$Res>
    implements _$VisitCopyWith<$Res> {
  __$VisitCopyWithImpl(this._self, this._then);

  final _Visit _self;
  final $Res Function(_Visit) _then;

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? customerId = null,Object? visitDate = null,Object? status = null,Object? location = null,Object? notes = null,Object? activitiesDone = null,Object? createdAt = freezed,}) {
  return _then(_Visit(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,activitiesDone: null == activitiesDone ? _self._activitiesDone : activitiesDone // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
