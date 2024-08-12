import 'package:dio/dio.dart';
import 'package:flutter_hub/utils/parse_expires_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  // await login();
  parseCookie();
}

Future<void> login() async {
  Dio dio = Dio();

  // 构建请求参数
  Map<String, dynamic> params = {
    'username': 'fl_wan',
    'password': 'p@ssw0rd123',
  };

  FormData formData = FormData.fromMap({
    'username': 'fl_wan',
    'password': 'p@ssw0rd123',
  });

  try {
    // 发起 POST 请求
    Response response = await dio.post(
      'https://www.wanandroid.com/user/login',
      data: params,
      queryParameters: params,
    );

    // 处理响应
    if (response.statusCode == 200) {
      print('Login successful');
      print(response.data); // 输出响应数据
    } else {
      print('Failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

void parseCookie() {
  String cookieString = '''set-cookie: JSESSIONID=472A54CFEE287E93D98D98BB5A227856; Path=/; Secure; HttpOnly
set-cookie: loginUserName=fl_wan; Expires=Wed, 04-Sep-2024 10:01:50 GMT; Path=/
set-cookie: token_pass=57f07fa973a383b1b8686c391a7ee789; Expires=Wed, 04-Sep-2024 10:01:50 GMT; Path=/
set-cookie: loginUserName_wanandroid_com=fl_wan; Domain=wanandroid.com; Expires=Wed, 04-Sep-2024 10:01:50 GMT; Path=/
set-cookie: token_pass_wanandroid_com=52f07fa973a383b0b8786c391a7ee956; Domain=wanandroid.com; Expires=Wed, 04-Sep-2024 10:01:50 GMT; Path=/''';

  print('Cookie 字符串:');
  print(cookieString);

  String? expiresTime = extractExpiresTime(cookieString);
  print('\nExpires 时间: $expiresTime');

  if (expiresTime != null) {
    DateTime? expiresDate = parseExpiresDate(expiresTime);
    print('解析后的 Expires 日期: $expiresDate');
  }
}
