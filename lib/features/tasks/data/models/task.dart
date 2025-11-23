import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/mappers/timestamp_converter.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
sealed class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required bool isDone,
    required String ownerEmail,
    required List<String> sharedWith,
    @TimestampConverter()
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
