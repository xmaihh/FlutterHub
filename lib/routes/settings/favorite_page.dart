import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Article> articles = [];
  List<Website> websites = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    // 模拟网络请求延迟
    await Future.delayed(Duration(seconds: 1));

    // 这里应该是从API或本地存储加载数据
    // 为了演示，我们使用模拟数据
    articles = [
      Article(
        id: 27996,
        title: "一文掌握直播技术：实时音视频采集、编码、传输与播放",
        author: "干货",
        chapterName: "干货资源",
        niceDate: "2024-06-06 14:00",
        link: "https://www.xiangxueketang.cn/enjoy/play/native_19",
      ),
      // 添加更多文章...
    ];

    websites = [
      Website(
        id: 22,
        name: "Flutter - Build apps for any screen",
        link: "https://flutter.dev",
        category: "源码",
      ),
      // 添加更多网站...
    ];

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    // 在实际应用中，这里应该重新从服务器获取数据
    await _loadData();
  }

  void _deleteArticle(Article article) {
    setState(() {
      articles.remove(article);
    });
    // 在实际应用中，这里应该同步删除操作到服务器或本地存储
  }

  void _deleteWebsite(Website website) {
    setState(() {
      websites.remove(website);
    });
    // 在实际应用中，这里应该同步删除操作到服务器或本地存储
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '收藏文章'),
            Tab(text: '收藏网址'),
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
          ? _buildEmptyState('暂无收藏文章')
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
                    SizedBox(height: 4),
                    Text('作者: ${article.author}'),
                    Text('分类: ${article.chapterName}'),
                    Text('日期: ${article.niceDate}'),
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
          ? _buildEmptyState('暂无收藏网址')
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
                subtitle: Text(website.category),
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

// Article 和 Website 类保持不变

class Article {
  final int id;
  final String title;
  final String author;
  final String chapterName;
  final String niceDate;
  final String link;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.chapterName,
    required this.niceDate,
    required this.link,
  });
}

class Website {
  final int id;
  final String name;
  final String link;
  final String category;

  Website({
    required this.id,
    required this.name,
    required this.link,
    required this.category,
  });
}
