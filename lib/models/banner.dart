import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner {
  Banner();

  @JsonKey(name: 'id')
  late num bid;
  late String desc;
  late String imagePath;
  late num isVisible;
  late num order;
  late String title;
  late num type;
  late String url;

  factory Banner.fromJson(Map<String,dynamic> json) => _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);

  @override
  String toString() {
    return 'Banner(id: $bid, desc: $desc, imagePath: $imagePath, isVisible: $isVisible, order: $order, title: $title, type: $type, url: $url)';
  }
}