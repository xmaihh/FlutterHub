// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      completeDate: (json['completeDate'] as num?)?.toInt(),
      completeDateStr: json['completeDateStr'] as String?,
      content: json['content'] as String,
      date: (json['date'] as num).toInt(),
      dateStr: json['dateStr'] as String,
      id: (json['id'] as num).toInt(),
      priority: (json['priority'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      title: json['title'] as String,
      type: (json['type'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'completeDate': instance.completeDate,
      'completeDateStr': instance.completeDateStr,
      'content': instance.content,
      'date': instance.date,
      'dateStr': instance.dateStr,
      'id': instance.id,
      'priority': instance.priority,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
    };
