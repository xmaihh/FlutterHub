import 'dart:io';

import 'package:dio/dio.dart';

Future<void> makeRequest() async {
  final dio = Dio();
  try {
    final response = await dio.get(
      'https://api.github.com/repos/xmaihh/FlutterHub/releases/latest',
      options: Options(
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          HttpHeaders.userAgentHeader: 'curl/7.79.1',
          HttpHeaders.acceptHeader: '*/*',
        },
        followRedirects: true,
        validateStatus: (status) {
          return status! < 500;
        },
        responseType: ResponseType.json,
      ),
    );

    final rateLimitResponse = await dio.get(
      'https://api.github.com/rate_limit',
      options: Options(
        headers: {
          // HttpHeaders.acceptHeader: 'application/vnd.github+json',
          // 'X-GitHub-Api-Version': '2022-11-28',
          // 'Authorization': 'Bearer $token',
          "User-Agent": "flutter_hub/1.0.0+1",
          "Accept": "*/*",
        },
      ),
    );

    print('Rate limit info: ${rateLimitResponse.data}');

    print('Response: ${response.data}');
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionError) {
      print('Connection error: ${e.message}');
      // Handle connection error (e.g., show a user-friendly message)
    } else {
      print('Dio error: ${e.type} - ${e.message}');
      // Handle other Dio errors
    }
  } catch (e) {
    print('Unexpected error: $e');
    // Handle unexpected errors
  }
}
