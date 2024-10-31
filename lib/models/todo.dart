import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  int? completeDate;
  String? completeDateStr;
  String content;
  int date;
  String dateStr;
  int id;
  int priority;
  int status;
  String title;
  int type;
  int userId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isDone = false; //是否完成

  Todo({
    required this.completeDate,
    required this.completeDateStr,
    required this.content,
    required this.date,
    required this.dateStr,
    required this.id,
    required this.priority,
    required this.status,
    required this.title,
    required this.type,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  bool Done() => (status == 1);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

