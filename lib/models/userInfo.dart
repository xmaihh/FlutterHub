import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo();

  late bool admin;
  late List chapterTops;
  late num coinCount;
  late List collectIds;
  late String email;
  late String icon;
  late num id;
  late String nickname;
  late String password;
  late String publicName;
  late String token;
  late num type;
  late String username;
  
  factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
