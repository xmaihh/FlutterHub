import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/common/constants.dart';

import '../api/api_client.dart';
import '../models/index.dart';

class ApiService {
  final ApiClient _apiClient;

  ApiService(this._apiClient);

  Future<T> handleApiCall<T>(Future<T> Function() apiCall, BuildContext context) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      _handleDioError(e, context);
      rethrow;
    } catch (e) {
      _handleGeneralError(e, context);
      rethrow;
    }
  }

  void _handleDioError(DioException e, BuildContext context) {
    String errorMessage;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = '网络连接超时';
        break;
      case DioExceptionType.badResponse:
        errorMessage = '服务器响应错误: ${e.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        errorMessage = '请求被取消';
        break;
      default:
        errorMessage = '发生未知错误';
        break;
    }
    _showErrorDialog(context, errorMessage);
  }

  void _handleGeneralError(dynamic e, BuildContext context) {
    _showErrorDialog(context, '发生错误: $e');
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('错误'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // API调用方法
  Future<dynamic> fetchArticles(BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get('/article/list/0/json');
      return response.data;
    }, context);
  }

// 添加其他API调用方法...
  Future<ResponseModel<User>> fetchUser(BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.userInfoEndpoint);
      print(response.data.toString());
      if (response.statusCode == 200) {
        ResponseModel<User> res = ResponseModel<User>.fromJson(response.data, (json) => User.fromJson(json));
        print(res.errorCode);
        print(res.errorMsg);
      }
      return ResponseModel<User>.fromJson(response.data, (json) => User.fromJson(json));
    }, context);
  }
}
