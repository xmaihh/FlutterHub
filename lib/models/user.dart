import 'package:json_annotation/json_annotation.dart';
import "coinInfo.dart";
import "userInfo.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  CoinInfo? coinInfo;
  UserInfo? userInfo;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
