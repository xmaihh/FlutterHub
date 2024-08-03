import 'package:dio/dio.dart';

import '../common/constants.dart';
import '../services/auth_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;
  late Dio _dio;
  final AuthService _authService = AuthService();

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
    // 添加拦截器、错误处理等...
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 在每个请求中添加cookie
        String? cookie = await _authService.getCookie();
        if (cookie != null) {
          options.headers['Cookie'] = cookie;
        }
        return handler.next(options);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

// 添加其他HTTP方法...
}
