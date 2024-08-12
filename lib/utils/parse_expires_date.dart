import 'package:intl/intl.dart';

String? extractExpiresTime(String cookieString) {
  RegExp exp = RegExp(r'Expires=(.*?GMT)');
  Match? match = exp.firstMatch(cookieString);
  return match?.group(1);
}

DateTime? parseExpiresDate(String expiresTime) {
  try {
    DateFormat dateFormat = DateFormat('EEE, dd-MMM-yyyy HH:mm:ss zzz', 'en_US');
    return dateFormat.parse(expiresTime);
  } catch (e) {
    print('解析日期时出错: $e');
    return null;
  }
}
