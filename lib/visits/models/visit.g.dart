// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Visit _$VisitFromJson(Map<String, dynamic> json) => _Visit(
  id: (json['id'] as num?)?.toInt(),
  customerId: (json['customer_id'] as num).toInt(),
  visitDate: json['visit_date'] as String,
  status: json['status'] as String,
  location: json['location'] as String,
  notes: json['notes'] as String,
  activitiesDone: _parseActivities(json['activities_done']),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$VisitToJson(_Visit instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'customer_id': instance.customerId,
  'visit_date': instance.visitDate,
  'status': instance.status,
  'location': instance.location,
  'notes': instance.notes,
  'activities_done': instance.activitiesDone,
  if (instance.createdAt case final value?) 'created_at': value,
};
