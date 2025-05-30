
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  const factory Activity({
    required int id,
    required String description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) => _$ActivityFromJson(json);
}