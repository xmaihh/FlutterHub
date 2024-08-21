import 'dart:convert';

import 'package:flutter_hub/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("json_obj", () {
    String json_str = '{"data":{"admin":false,"chapterTops":[],"coinCount":33,"collectIds":[],"email":"","icon":"","id":162789,"nickname":"wana","password":"","publicName":"wana","token":"","type":0,"username":"wana"},"errorCode":0,"errorMsg":""}';
    Map<String, dynamic> json = jsonDecode(json_str);
    ResponseModel<UserInfo> result = ResponseModel.fromJson(json, (json) => UserInfo.fromJson(json));

    print(result);
    print("------分割线-----");
    print(result.data);

    expect(result.data?.id, 162789);
    expect(result.data?.coinCount, 33);
    expect(result.data?.nickname, "wana");
    expect(result.data?.admin, false);
  });

  // 预期输出：
  // ResponseModel(data: UserInfo(admin: false, chapterTops: [], coinCount: 33, collectIds: [], email: , icon: , id: 162789, nickname: wana, password: , publicName: wana, token: , type: 0, username: wana), errorCode: 0, errorMsg: )
  // ------分割线-----
  // UserInfo(admin: false, chapterTops: [], coinCount: 33, collectIds: [], email: , icon: , id: 162789, nickname: wana, password: , publicName: wana, token: , type: 0, username: wana)

  test("json_list", () {
    String json_str = '{"data":[{"desc":"我们支持订阅啦~","id":30,"imagePath":"https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png","isVisible":1,"order":2,"title":"我们支持订阅啦~","type":0,"url":"https://www.wanandroid.com/blog/show/3352"},{"desc":"","id":6,"imagePath":"https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png","isVisible":1,"order":1,"title":"我们新增了一个常用导航Tab~","type":1,"url":"https://www.wanandroid.com/navi"},{"desc":"一起来做个App吧","id":10,"imagePath":"https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png","isVisible":1,"order":1,"title":"一起来做个App吧","type":1,"url":"https://www.wanandroid.com/blog/show/2"}],"errorCode":0,"errorMsg":""}';
    Map<String, dynamic> json = jsonDecode(json_str);
    ResponseListModel<Banner> result = ResponseListModel.fromJson(json, (json) => Banner.fromJson(json));

    print(result);
    print("------分割线-----");
    print(result.data);

    expect(result.data?.length, 3);
    expect(result.data?[0].title, "我们支持订阅啦~");
    expect(result.data?[1].bid, 6);
    expect(result.data?[2].url, "https://www.wanandroid.com/blog/show/2");
  });
  // 预期输出
  // ResponseListModel(data: [Banner(desc: 我们支持订阅啦~, id: 30, imagePath: https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png, isVisible: 1, order: 2, title: 我们支持订阅啦~, type: 0, url: https://www.wanandroid.com/blog/show/3352), Banner(desc: , id: 6, imagePath: https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png, isVisible: 1, order: 1, title: 我们新增了一个常用导航Tab~, type: 1, url: https://www.wanandroid.com/navi), Banner(desc: 一起来做个App吧, id: 10, imagePath: https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png, isVisible: 1, order: 1, title: 一起来做个App吧, type: 1, url: https://www.wanandroid.com/blog/show/2)], errorCode: 0, errorMsg: "")
  // ------分割线-----
  // [Banner(desc: 我们支持订阅啦~, id: 30, imagePath: https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png, isVisible: 1, order: 2, title: 我们支持订阅啦~, type: 0, url: https://www.wanandroid.com/blog/show/3352), Banner(desc: , id: 6, imagePath: https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png, isVisible: 1, order: 1, title: 我们新增了一个常用导航Tab~, type: 1, url: https://www.wanandroid.com/navi), Banner(desc: 一起来做个App吧, id: 10, imagePath: https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png, isVisible: 1, order: 1, title: 一起来做个App吧, type: 1, url: https://www.wanandroid.com/blog/show/2)]

  test("json_all", (){
    String json_str = '{"data":[{"desc":"我们支持订阅啦~","id":30,"imagePath":"https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png","isVisible":1,"order":2,"title":"我们支持订阅啦~","type":0,"url":"https://www.wanandroid.com/blog/show/3352"},{"desc":"","id":6,"imagePath":"https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png","isVisible":1,"order":1,"title":"我们新增了一个常用导航Tab~","type":1,"url":"https://www.wanandroid.com/navi"},{"desc":"一起来做个App吧","id":10,"imagePath":"https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png","isVisible":1,"order":1,"title":"一起来做个App吧","type":1,"url":"https://www.wanandroid.com/blog/show/2"}],"errorCode":0,"errorMsg":""}';
    // Deserialize JSON to ResponseModel<List<Item>>
    Map<String, dynamic> jsonListMap = jsonDecode(json_str);
    ResponseModel<List<Banner>> result = ResponseModel.fromJson(
      jsonListMap,
          (json) => (json as List<dynamic>).map((item) => Banner.fromJson(item as Map<String, dynamic>)).toList(),
    );

    print(result);
    print("------分割线-----");
    print(result.data);
  });
}
