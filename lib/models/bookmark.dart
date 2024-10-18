import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable()
class Bookmark {
  String desc;
  String icon;
  int id;
  String link;
  String name;
  int order;
  int userId;
  int visible;

  Bookmark({
    required this.desc,
    required this.icon,
    required this.id,
    required this.link,
    required this.name,
    required this.order,
    required this.userId,
    required this.visible,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
