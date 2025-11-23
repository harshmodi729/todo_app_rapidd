// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  isDone: json['isDone'] as bool,
  ownerEmail: json['ownerEmail'] as String,
  sharedWith: (json['sharedWith'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'isDone': instance.isDone,
  'ownerEmail': instance.ownerEmail,
  'sharedWith': instance.sharedWith,
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
