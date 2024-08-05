import 'package:json_annotation/json_annotation.dart';

part 'coinInfo.g.dart';

@JsonSerializable()
class CoinInfo {
  CoinInfo();

  late num coinCount;
  late num level;
  late String nickname;
  late String rank;
  late num userId;
  late String username;
  
  factory CoinInfo.fromJson(Map<String,dynamic> json) => _$CoinInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CoinInfoToJson(this);

  @override
  String toString() {
    return 'CoinInfo(coinCount: $coinCount, level: $level, nickname: $nickname, rank: $rank, userId: $userId, username: $username)';
  }
}
