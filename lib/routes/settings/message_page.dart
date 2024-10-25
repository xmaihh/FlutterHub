import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/models/index.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/widgets/empty_state.dart';
import 'package:flutter_hub/widgets/loading_indicator.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Message> unreadMessages = [];
  List<Message> readMessages = [];
  final _apiServer = getIt<ApiService>();

  // 分页相关变量
  int _unreadPage = 1;
  int _readPage = 1;
  bool _unreadHasMore = true;
  bool _readHasMore = true;

  // 加载状态
  bool _unreadLoadingMore = false;
  bool _readLoadingMore = false;
  bool _unreadRefreshing = false;
  bool _readRefreshing = false;

  // 滚动控制器
  final ScrollController _unreadScrollController = ScrollController();
  final ScrollController _readScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 初始加载数据
    _loadUnreadMessages(isRefresh: true);
    _loadReadMessages(isRefresh: true);

    // 添加滚动监听
    _unreadScrollController.addListener(_unreadScrollListener);
    _readScrollController.addListener(_readScrollListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _unreadScrollController.dispose();
    _readScrollController.dispose();
    super.dispose();
  }

  /// 未读消息滚动监听
  void _unreadScrollListener() {
    if (_unreadScrollController.position.pixels >= _unreadScrollController.position.maxScrollExtent - 50) {
      if (!_unreadLoadingMore && !_unreadRefreshing && _unreadHasMore) {
        _loadUnreadMessages(isRefresh: false);
      }
    }
  }

  /// 已读消息滚动监听
  void _readScrollListener() {
    if (_readScrollController.position.pixels >= _readScrollController.position.maxScrollExtent - 50) {
      if (!_readLoadingMore && !_readRefreshing && _readHasMore) {
        _loadReadMessages(isRefresh: false);
      }
    }
  }

  // 加载未读消息
  Future<void> _loadUnreadMessages({required bool isRefresh}) async {
    if (isRefresh) {
      if (_unreadRefreshing) return;
      setState(() {
        _unreadRefreshing = true;
      });
    } else {
      if (_unreadLoadingMore) return;
      setState(() {
        _unreadLoadingMore = true;
      });
    }

    try {
      if (isRefresh) {
        _unreadPage = 1;
      }

      List<Message> newMessages = [];
      ResponseModel<PaginationModel<Message>>? res = await _apiServer.fetchUnReadMessages(_unreadPage, context);
      if (res?.data != null) {
        newMessages = res?.data?.datas ?? [];
        _unreadHasMore = !(res?.data?.over == true);
      }

      // 模拟获取数据
      // List<Message> newMessages = List.generate(
      //   isRefresh ? 10 : 5,
      //       (index) => Message(
      //     category: 1,
      //     date: DateTime.now().millisecondsSinceEpoch,
      //     fromUser: "用户${index + 1}",
      //     fromUserId: index + 1,
      //     fullLink: "https://example.com",
      //     id: index + 1,
      //     isRead: 0,
      //     link: "/message/detail",
      //     message: "这是一条测试消息内容，索引为 ${index + 1}",
      //     niceDate: "刚刚",
      //     tag: "测试",
      //     title: "测试消息 ${index + 1}",
      //     userId: 1,
      //   ),
      // );

      setState(() {
        if (isRefresh) {
          unreadMessages = newMessages;
        } else {
          unreadMessages.addAll(newMessages);
        }

        if (_unreadHasMore) {
          _unreadPage++;
        }
      });
    } catch (e) {
      // TODO: 错误处理
    } finally {
      setState(() {
        if (isRefresh) {
          _unreadRefreshing = false;
        } else {
          _unreadLoadingMore = false;
        }
      });
    }
  }

  // 加载已读消息
  Future<void> _loadReadMessages({required bool isRefresh}) async {
    if (isRefresh) {
      if (_readRefreshing) return;
      setState(() {
        _readRefreshing = true;
      });
    } else {
      if (_readLoadingMore) return;
      setState(() {
        _readLoadingMore = true;
      });
    }

    try {
      if (isRefresh) {
        _readPage = 1;
      }

      List<Message> newMessages = [];
      ResponseModel<PaginationModel<Message>>? res = await _apiServer.fetchReadMessages(_readPage, context);
      if (res?.data != null) {
        newMessages = res?.data?.datas ?? [];
        _readHasMore = !(res?.data?.over == true);
      }
      // 模拟获取数据
      // List<Message> newMessages = List.generate(
      //   isRefresh ? 10 : 5,
      //   (index) => Message(
      //     category: 1,
      //     date: DateTime.now().millisecondsSinceEpoch,
      //     fromUser: "用户${index + 1}",
      //     fromUserId: index + 1,
      //     fullLink: "https://example.com",
      //     id: index + 1,
      //     isRead: 1,
      //     link: "/message/detail",
      //     message: "这是一条已读消息内容，索引为 ${index + 1}",
      //     niceDate: "刚刚",
      //     tag: "测试",
      //     title: "已读消息 ${index + 1}",
      //     userId: 1,
      //   ),
      // );

      setState(() {
        if (isRefresh) {
          readMessages = newMessages;
        } else {
          readMessages.addAll(newMessages);
        }

        if (_readHasMore) {
          _readPage++;
        }
      });
    } catch (e) {
      // TODO: 错误处理
    } finally {
      setState(() {
        if (isRefresh) {
          _readRefreshing = false;
        } else {
          _readLoadingMore = false;
        }
      });
    }
  }

  Widget _buildMessageItem(Message message) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          // TODO: 处理消息点击事件
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.tag,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                message.message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    message.fromUser,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    message.niceDate,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(bool isUnread) {
    final messages = isUnread ? unreadMessages : readMessages;
    final loadingMore = isUnread ? _unreadLoadingMore : _readLoadingMore;
    final refreshing = isUnread ? _unreadRefreshing : _readRefreshing;
    final hasMore = isUnread ? _unreadHasMore : _readHasMore;
    final controller = isUnread ? _unreadScrollController : _readScrollController;

    return RefreshIndicator(
      onRefresh: () async {
        if (isUnread) {
          await _loadUnreadMessages(isRefresh: true);
        } else {
          await _loadReadMessages(isRefresh: true);
        }
      },
      child: CustomScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 4),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == messages.length) {
                  // 只在加载更多时显示底部加载指示器
                  return loadingMore && hasMore ? LoadingIndicator() : Container(height: 0);
                }
                return _buildMessageItem(messages[index]);
              },
              childCount: messages.length + (loadingMore && hasMore ? 1 : 0),
            ),
          ),
          // 空状态显示
          SliverToBoxAdapter(
            child: messages.isEmpty && !refreshing ? EmptyStateWidget(message: isUnread ? AppLocalizations.of(context).message_page_no_unread_message : AppLocalizations.of(context).message_page_no_read_message, subMessage: AppLocalizations.of(context).message_page_refresh) : Container(height: 0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).message_page_message),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.of(context).message_page_unread_message),
            Tab(text: AppLocalizations.of(context).message_page_read_message),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMessageList(true), // 未读消息列表
          _buildMessageList(false), // 历史消息列表
        ],
      ),
    );
  }
}
