import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Object?> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json == null) return DateTime.now();

    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    if (json is DateTime) return json;
    throw Exception("Invalid date format: $json");
  }

  @override
  Object toJson(DateTime date) => date.toIso8601String();
}
