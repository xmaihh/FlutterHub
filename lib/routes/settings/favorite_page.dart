import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/models/index.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/widgets/empty_state.dart';
import 'package:flutter_hub/widgets/loading_indicator.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Favorite> articles = [];
  List<Bookmark> websites = [];
  final _apiService = getIt<ApiService>();

  // 分页相关变量 收藏文章是分页接口|收藏网址不是分页
  int _favoritePage = 0;
  bool _favoriteHasMore = true;

  // 加载状态
  bool _favoriteLoadingMore = false;
  bool _favoriteRefreshing = false;
  bool _bookmarkRefreshing = false;

  // 滚动控制器
  ScrollController _favoriteScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 初始化加载数据
    _loadArticles(isRefresh: true);
    _loadBookmarks(isRefresh: true);

    // 添加滚动监听
    _favoriteScrollController.addListener(_onFavoriteScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _favoriteScrollController.dispose();
    super.dispose();
  }

  /// 收藏文章滚动监听
  void _onFavoriteScroll() {
    if (_favoriteScrollController.position.pixels >= _favoriteScrollController.position.maxScrollExtent - 50) {
      if (!_favoriteLoadingMore && !_favoriteRefreshing && _favoriteHasMore) {
        _loadArticles(isRefresh: false);
      }
    }
  }

  /// 加载收藏文章
  Future<void> _loadArticles({required bool isRefresh}) async {
    if (isRefresh) {
      if (_favoriteRefreshing) return;
      setState(() {
        _favoriteRefreshing = true;
      });
    } else {
      if (_favoriteLoadingMore) return;
      setState(() {
        _favoriteLoadingMore = true;
      });
    }

    try {
      if (isRefresh) {
        _favoritePage = 0;
      }

      List<Favorite> newArticles = [];
      ResponseModel<PaginationModel<Favorite>>? res = await _apiService.fetchCollectArticles(_favoritePage, context);
      if (res?.data != null) {
        newArticles = res?.data?.datas ?? [];
        _favoriteHasMore = !(res?.data?.over == true);
      }

      setState(() {
        if (isRefresh) {
          articles = newArticles;
        } else {
          articles.addAll(newArticles);
        }

        if (_favoriteHasMore) {
          _favoritePage++;
        }
      });
    } catch (e) {
      // TODO: 错误处理
    } finally {
      setState(() {
        if (isRefresh) {
          _favoriteRefreshing = false;
        } else {
          _favoriteLoadingMore = false;
        }
      });
    }
  }

  Future<void> _loadBookmarks({required bool isRefresh}) async {
    if (isRefresh) {
      if (_bookmarkRefreshing) return;
      setState(() {
        _bookmarkRefreshing = true;
      });
    }

    try {
      ResponseListModel<Bookmark>? res = await _apiService.fetchBookmarks(context);
      if (res?.data != null) {
        setState(() {
          websites
            ..clear()
            ..addAll(res?.data ?? []);
        });
      }
    } catch (e) {
      // TODO: 错误处理
    } finally {
      setState(() {
        if (isRefresh) {
          _bookmarkRefreshing = false;
        }
      });
    }
  }

  void _deleteArticle(Favorite article) {
    setState(() {
      articles.remove(article);
    });
    // 在实际应用中，这里应该同步删除操作到服务器或本地存储
  }

  void _deleteWebsite(Bookmark website) {
    setState(() {
      websites.remove(website);
    });
    // 在实际应用中，这里应该同步删除操作到服务器或本地存储
  }

  void _editBookmark(Bookmark bookmark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = bookmark.name;
        String newLink = bookmark.link;
        return AlertDialog(
          title: Text(AppLocalizations.of(context).favorite_page_edit_bookmark),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context).favorite_page_edit_bookmark_name),
                onChanged: (value) => newName = value,
                controller: TextEditingController(text: bookmark.name),
              ),
              TextField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context).favorite_page_edit_bookmark_link),
                onChanged: (value) => newLink = value,
                controller: TextEditingController(text: bookmark.link),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).favorite_page_edit_bookmark_cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).favorite_page_edit_bookmark_confirm),
              onPressed: () {
                setState(() {
                  bookmark.name = newName;
                  bookmark.link = newLink;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).favorite_page_favorites),
        bottom: TabBar(
          dividerHeight: 0,
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.of(context).favorite_page_my_favorites),
            Tab(text: AppLocalizations.of(context).favorite_page_my_bookmarks),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildArticleList(),
          _buildBookmarkList(),
        ],
      ),
    );
  }

  Widget _buildArticleItem(Favorite article) {
    return Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
            title: Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 4),
                Row(children: [
                  Icon(Icons.person, size: 16.0, color: Colors.grey),
                  SizedBox(width: 4.0),
                  Text(article.author, style: TextStyle(color: Colors.grey)),
                ]),
                Row(children: [
                  Icon(Icons.label, size: 16.0, color: Colors.grey),
                  SizedBox(width: 4.0),
                  Text(article.chapterName, style: TextStyle(color: Colors.grey)),
                ]),
                Row(children: [
                  Icon(Icons.access_time, size: 16.0, color: Colors.grey),
                  SizedBox(width: 4.0),
                  Text(article.niceDate, style: TextStyle(color: Colors.grey)),
                ]),
              ],
            )));
  }

  Widget _buildArticleList() {
    return RefreshIndicator(
      onRefresh: () async {
        _loadArticles(isRefresh: true);
      },
      child: CustomScrollView(
        controller: _favoriteScrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          SliverList.builder(
              itemCount: articles.length + (_favoriteLoadingMore && _favoriteHasMore ? 1 : 0),
              itemBuilder: (context, index) {
                // 只在加载更多时显示底部加载指示器
                if (_favoriteLoadingMore && _favoriteHasMore && index == articles.length) {
                  return LoadingIndicator();
                }
                final article = articles[index];
                return Dismissible(
                    key: Key(article.id.toString()),
                    background: Container(
                      color: Colors.deepOrange,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.delete_outline_outlined, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteArticle(article);
                    },
                    child: _buildArticleItem(article));
              }),
          // 空状态显示
          SliverToBoxAdapter(
              child: articles.isEmpty && !_favoriteRefreshing
                  ? EmptyStateWidget(
                      message: AppLocalizations.of(context).favorite_page_no_favorites,
                      subMessage: AppLocalizations.of(context).favorite_page_refresh,
                    )
                  : Container(height: 0)),
        ],
      ),
    );
  }

  Widget _buildBookmarkList() {
    return RefreshIndicator(
      onRefresh: () async {
        _loadBookmarks(isRefresh: true);
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 4),
          ),
          SliverList.builder(
              itemCount: websites.length,
              itemBuilder: (context, index) {
                final website = websites[index];
                return Dismissible(
                    key: Key(website.id.toString()),
                    background: Container(
                      color: Colors.deepOrange,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteWebsite(website);
                    },
                    child: Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(website.name[0].toUpperCase()),
                          ),
                          title: Text(website.name),
                          subtitle: Text(website.desc),
                          trailing: Icon(Icons.link),
                          onTap: () {
                            // 处理网站点击事件，例如打开WebView
                          },
                        )));
              }),
          // 空状态显示
          SliverToBoxAdapter(child: websites.isEmpty && !_bookmarkRefreshing ? EmptyStateWidget(message: AppLocalizations.of(context).favorite_page_no_bookmarks, subMessage: AppLocalizations.of(context).favorite_page_refresh) : Container(height: 0))
        ],
      ),
    );
  }
}
