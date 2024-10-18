import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/models/index.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/widgets/show_toast.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Favorite> articles = [];
  List<Bookmark> websites = [];
  int currentPage = 0;
  bool isLoading = false;
  bool hasMoreData = true;
  ScrollController _scrollController = ScrollController();
  final _apiService = getIt<ApiService>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCollectArticles();
    fetchBookmarks();
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchCollectArticles() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    ResponseModel<PaginationModel<Favorite>>? res = await _apiService.fetchCollectArticles(0, context);
    if (res?.data != null) {
      setState(() {
        currentPage++;
        articles.addAll(res?.data?.datas ?? []);
        hasMoreData = !(res?.data?.over == true);
        isLoading = false;
      });
    } else {
      showToast("${res?.errorMsg}${res?.errorCode}");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchBookmarks() async {
    ResponseListModel<Bookmark>? res = await _apiService.fetchBookmarks(context);
    if (res?.data != null) {
      setState(() {
        websites
          ..clear()
          ..addAll(res?.data ?? []);
      });
    } else {
      showToast("${res?.errorMsg}${res?.errorCode}");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      currentPage = 0;
      articles.clear();
    });
    fetchCollectArticles();
    fetchBookmarks();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!isLoading && hasMoreData) {}
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
          _buildWebsiteList(),
        ],
      ),
    );
  }

  Widget _buildArticleList() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : articles.isEmpty
              ? _buildEmptyState(AppLocalizations.of(context).favorite_page_no_favorites)
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Dismissible(
                      key: Key(article.id.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _deleteArticle(article);
                      },
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // 处理文章点击事件，例如打开WebView
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildWebsiteList() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : websites.isEmpty
              ? _buildEmptyState(AppLocalizations.of(context).favorite_page_no_bookmarks)
              : ListView.builder(
                  itemCount: websites.length,
                  itemBuilder: (context, index) {
                    final website = websites[index];
                    return Dismissible(
                      key: Key(website.id.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
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
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
