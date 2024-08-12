import 'dart:io';

import 'package:dio/dio.dart';

import '../common/constants.dart';
import '../common/global.dart';
import '../services/cache_manager.dart';

typedef CookieProvider = Future<String?> Function();

class ApiClient {
  late Dio _dio;
  final CookieProvider _cookieProvider;
  final CacheManager _cacheManager;

  ApiClient(this._cookieProvider, this._cacheManager) {
    _dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ));
    // 添加拦截器、错误处理等...
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 在每个请求中添加cookie
        String? cookie = await _cookieProvider();
        if (cookie != null) {
          options.headers[HttpHeaders.cookieHeader] = cookie;
        }
        return handler.next(options);
      },
    ));
    // 添加日志拦截器
    _dio.interceptors.add(LogInterceptor());
    // 添加缓存插件
    _dio.interceptors.add(Global.netCache);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useCache = false,
    Duration? cacheDuration,
  }) async {
    if (useCache) {
      final cachedData = await _cacheManager.getCache(path);
      if (cachedData != null) {
        return Response(
          requestOptions: RequestOptions(path: path),
          data: cachedData,
          statusCode: 200,
        );
      }
    }

    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (useCache) {
        await _cacheManager.setCache(path, response.data, duration: cacheDuration);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(path, data: data, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  // 其他 HTTP 方法...

  Future<void> clearCache() async {
    await _cacheManager.clearAllCache();
  }
}
