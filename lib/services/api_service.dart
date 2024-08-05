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
      return ResponseModel<User>.fromJson(response.data, (json) => User.fromJson(json));
    }, context);
  }
}

// import 'package:flutter/material.dart';
// import 'api_service.dart';

// class ArticleListScreen extends StatefulWidget {
//   @override
//   _ArticleListScreenState createState() => _ArticleListScreenState();
// }
//
// class _ArticleListScreenState extends State<ArticleListScreen> {
//   final ApiService _apiService = ApiService();
//   List<dynamic> articles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchArticles();
//   }
//
//   Future<void> _fetchArticles() async {
//     try {
//       final data = await _apiService.fetchArticles(context);
//       setState(() {
//         articles = data['data']['datas'];
//       });
//     } catch (e) {
//       // 错误已经在ApiService中处理，这里可以做一些额外的处理
//       print('Failed to fetch articles: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Articles')),
//       body: ListView.builder(
//         itemCount: articles.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(articles[index]['title']),
//             // ... 其他UI逻辑
//           );
//         },
//       ),
//     );
//   }
// }
