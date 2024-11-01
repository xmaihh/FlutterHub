import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/common/constants.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/utils/logger.dart';

import '../api/api_client.dart';
import '../models/banner.dart' as hub;
import '../models/index.dart';

class ApiService {
  final ApiClient _apiClient;
  bool _isShowingErrorDialog = false;
  final _errorDialogQueue = Queue<String>();

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
        errorMessage = AppLocalizations.of(context).dio_exception_receive_timeout;
        break;
      case DioExceptionType.badResponse:
        errorMessage = AppLocalizations.of(context).dio_exception_bad_response(e.response?.statusCode.toString() ?? '');
        break;
      case DioExceptionType.cancel:
        errorMessage = AppLocalizations.of(context).dio_exception_cancel;
        break;
      default:
        errorMessage = AppLocalizations.of(context).dio_exception_default;
        break;
    }
    _showErrorDialog(context, errorMessage);
  }

  void _handleGeneralError(dynamic e, BuildContext context) {
    _showErrorDialog(context, AppLocalizations.of(context).dio_exception_general_error(e.toString()));
  }

  void _showErrorDialog(BuildContext context, String message) {
    _errorDialogQueue.add(message);
    if (!_isShowingErrorDialog) {
      _isShowingErrorDialog = true;
      _showErrorDialogHelper(context);
    }
  }

  void _showErrorDialogHelper(BuildContext context) {
    if (_errorDialogQueue.isNotEmpty) {
      final msg = _errorDialogQueue.removeFirst(); // Get the next message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).dio_exception_error_dialog_title),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context).dio_exception_error_dialog_ok),
                onPressed: () {
                  Navigator.of(context).pop();
                  _isShowingErrorDialog = false;
                  _showErrorDialogHelper(context); // Show the next dialog if any
                },
              ),
            ],
          );
        },
      );
    }
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
  Future<ResponseListModel<Article>?> fetchTopArticles(BuildContext context, {required bool useCache}) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.topArticlesEndpoint, useCache: useCache);
      Log.info(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseListModel<Article>.fromJson(response.data, (json) => Article.fromJson(json));
      }
      return null;
    }, context);
  }

  /// 首页-文章列表
  Future<ResponseModel<PaginationModel<Article>>?> fetchArticles(int page, BuildContext context, {required bool useCache}) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.articlesEndpoint(page), useCache: useCache);
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
      return null;
    }, context);
  }

  /// 收藏文章列表
  Future<ResponseModel<PaginationModel<Favorite>>?> fetchCollectArticles(int page, BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.collectArticlesEndpoint(page));
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel<PaginationModel<Favorite>>.fromJson(response.data, (json) => PaginationModel<Favorite>.fromJson(json, Favorite.fromJson));
      }
      return null;
    }, context);
  }

  /// 收藏网站列表
  Future<ResponseListModel<Bookmark>?> fetchBookmarks(BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.bookmarkEndpoint);
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseListModel<Bookmark>.fromJson(response.data, (json) => Bookmark.fromJson(json));
      }
      return null;
    }, context);
  }

  /// 未读消息数量
  Future fetchUnreadMsgCount() async {
    final response = await _apiClient.get(Constants.msgCountUnreadEndpoint);
    print(response.data.toString());
    if (response.statusCode == 200) {
      return (response.data['data'] as int?) ?? 0;
    }
    return 0;
  }

  /// 已读消息列表
  Future<ResponseModel<PaginationModel<Message>>?> fetchReadMessages(int page, BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.msgReadListEndpoint(page));
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel<PaginationModel<Message>>.fromJson(response.data, (json) => PaginationModel<Message>.fromJson(json, Message.fromJson));
      }
      return null;
    }, context);
  }

  /// 未读消息列表
  Future<ResponseModel<PaginationModel<Message>>?> fetchUnReadMessages(int page, BuildContext context) async {
    return handleApiCall(() async {
      final response = await _apiClient.get(Constants.msgUnreadListEndpoint(page));
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel<PaginationModel<Message>>.fromJson(response.data, (json) => PaginationModel<Message>.fromJson(json, Message.fromJson));
      }
      return null;
    }, context);
  }

  /// 新增TODO
  Future addTodo(BuildContext context, String title, String content, String date, {int type = 0, int priority = 0}) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.addTodoEndpoint,
          data: FormData.fromMap({
            "title": title,
            "content": content,
            "date": date,
            "type": type,
            "priority": priority,
          }));
      print(response.data.toString());
    }, context);
  }

  /// 编辑TODO
  Future editTodo(BuildContext context, int todoId, String newTitle, String newContent, String newDate, {int status = 0, int type = 0, int priority = 0}) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.editTodoEndpoint(todoId), data: FormData.fromMap({"title": newTitle, "content": newContent, "date": newDate, "status": status, "type": type, "priority": priority}));
      print(response.data.toString());
    }, context);
  }

  /// 删除TODO
  Future deleteTodo(BuildContext context, int todoId) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.deleteTodoEndpoint(todoId));
      print(response.data.toString());
    }, context);
  }

  /// 更新TODO完成状态
  Future updateTodoCompletionStatus(BuildContext context, int todoId, bool isComplete) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.updateTodoCompletionStatusEndpoint(todoId), data: FormData.fromMap({"status": isComplete ? 1 : 0}));
      print(response.data.toString());
      if (response.statusCode == 200) {}
    }, context);
  }

  /// TODO列表
  Future<ResponseModel<PaginationModel<Todo>>?> fetchTodoList(BuildContext context, int page) async {
    return handleApiCall(() async {
      final response = await _apiClient.post(Constants.todoListEndpoint(page),
          data: FormData.fromMap({
            // status 状态， 1-完成；0未完成; 默认全部展示；
            // type 创建时传入的类型, 默认全部展示
            // priority 创建时传入的优先级；默认全部展示
            // orderby 1:完成日期顺序；2.完成日期逆序；3.创建日期顺序；4.创建日期逆序(默认)；
            'orderby': 3
          }));
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ResponseModel<PaginationModel<Todo>>.fromJson(response.data, (json) => PaginationModel<Todo>.fromJson(json, Todo.fromJson));
      }
      return null;
    }, context);
  }
}
