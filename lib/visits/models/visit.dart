import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit.freezed.dart';
part 'visit.g.dart';

@freezed
abstract class Visit with _$Visit {
  const factory Visit({
    @JsonKey(includeIfNull: false) int? id,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'visit_date') required String visitDate,
    required String status,
    required String location,
    required String notes,
    @JsonKey(name: 'activities_done', fromJson: _parseActivities)
    required List<String> activitiesDone,
    @JsonKey(name: 'created_at', includeIfNull: false) String? createdAt,
  }) = _Visit;

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
}

List<String> _parseActivities(dynamic value) {
  if (value == null) return [];
  if (value is List) {
    return value.map((e) => e.toString()).toList(); // ensures String
  }
  throw Exception("Invalid format for activities_done: $value");
}
