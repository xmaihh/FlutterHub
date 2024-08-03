import 'package:dio/dio.dart';

import '../utils/logger.dart';

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.info('REQUEST[${options.method}] => PATH: ${options.path}');
    Log.info('Headers:');
    options.headers.forEach((key, value) {
      Log.info('$key: $value');
    });
    Log.info('QueryParameters:');
    Log.info(options.queryParameters.toString());
    Log.info('Data:');
    Log.info(options.data);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.info('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    Log.info('Response Data:');
    Log.info(response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.info('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    Log.info('Error Message: ${err.message}');
    return super.onError(err, handler);
  }
}
