import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/common/constants.dart';
import 'package:flutter_hub/utils/logger.dart';

import '../api/api_client.dart';
import '../models/banner.dart' as hub;
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

  /// 个人信息接口
  Future<ResponseModel<User>?> retrieveUserData(BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.userInfoEndpoint);
      Log.info(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel<User>.fromJson(response.data, (json) => User.fromJson(json));
      }
      return null;
    }, context);
  }

  /// 首页banner
  Future<ResponseListModel<hub.Banner>?> fetchBanners(BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.bannersEndpoint, useCache: true);
      Log.info(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseListModel<hub.Banner>.fromJson(response.data, (json) => hub.Banner.fromJson(json));
      }
      return null;
    }, context);
  }

  /// 首页-置顶文章
  Future<ResponseListModel<Article>?> fetchTopArticles(BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.topArticlesEndpoint, useCache: true);
      Log.info(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseListModel<Article>.fromJson(response.data, (json) => Article.fromJson(json));
      }
      return null;
    }, context);
  }

  /// 首页-文章列表
  Future<ResponseModel<PaginationModel<Article>>?> fetchArticles(int page, BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.articlesEndpoint(page), useCache: true);
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel<PaginationModel<Article>>.fromJson(response.data, (json) => PaginationModel<Article>.fromJson(json, Article.fromJson));
      }
      return null;
    }, context);
  }

  /// 收藏站内文章
  Future<ResponseModel?> collect(int articleId, BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.collectEndpoint(articleId));
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data, (json) => {});
      }
      return null;
    }, context);
  }

  /// 取消收藏
  Future<ResponseModel?> uncollect(int articleId, BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.uncollectEndpoint(articleId));
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data, (json) => {});
      }
    }, context);
  }
}
