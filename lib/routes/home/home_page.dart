import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerItem> banners = [];
  List<ArticleItem> articles = [];

  @override
  void initState() {
    super.initState();
    fetchBanners();
    fetchArticles();
  }

  void fetchBanners() {
    // 模拟从API获取banner数据
    banners = [
      BannerItem(
        id: 30,
        title: "我们支持订阅啦~",
        desc: "我们支持订阅啦~",
        imagePath: "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
        url: "https://www.wanandroid.com/blog/show/3352",
      ),
      // 添加更多banner项...

      BannerItem(
        id: 6,
        imagePath: "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
        title: "我们新增了一个常用导航Tab~",
        url: "https://www.wanandroid.com/navi",
        desc: "我们新增了一个常用导航Tab~",
      ),
      BannerItem(
        desc: "一起来做个App吧",
        id: 10,
        imagePath: "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
        title: "一起来做个App吧",
        url: "https://www.wanandroid.com/blog/show/2"
      )

    ];
  }

// 在 fetchArticles 方法中，你可以这样初始化文章数据：
  void fetchArticles() {
    articles = [
      ArticleItem(
        id: 28807,
        title: "一文掌握Kotlin协程使用",
        author: "郭霖",
        niceDate: "12小时前",
        link: "https://mp.weixin.qq.com/s/lyaLrnFeLiWFk2NCgXZOgQ",
        tags: ["Kotlin", "协程"],
        isTop: true,
      ),
      // 添加更多文章项...
      ArticleItem(
        id: 28822,
        title: "鸿蒙next 下拉刷新上拉加载 来了",
        author: "坚果派_xq9527",
        niceDate: "18小时前",
        link: "https://juejin.cn/post/7386936832609337355",
        tags: [],
        isTop: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 实现刷新逻辑
        },
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildBanner(),
            SizedBox(height: 24),
            Text(
              '最新文章',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildArticleList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(banner.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        banner.desc,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildArticleList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article.isTop)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '置顶',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              Text(
                                article.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            article.isCollected ? Icons.favorite : Icons.favorite_border,
                            color: article.isCollected ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              article.isCollected = !article.isCollected;
                              // 在这里实现收藏/取消收藏的逻辑
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: article.tags.map((tag) => Chip(
                        label: Text(tag, style: TextStyle(fontSize: 12)),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                      )).toList(),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          article.author,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          article.niceDate,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // 处理文章点击事件，可以跳转到文章详情页
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// BannerItem 和 ArticleItem 类保持不变

class BannerItem {
  final int id;
  final String title;
  final String desc;
  final String imagePath;
  final String url;

  BannerItem({
    required this.id,
    required this.title,
    required this.desc,
    required this.imagePath,
    required this.url,
  });
}

class ArticleItem {
  final int id;
  final String title;
  final String author;
  final String niceDate;
  final String link;
  final List<String> tags;
  final bool isTop;
  bool isCollected;

  ArticleItem({
    required this.id,
    required this.title,
    required this.author,
    required this.niceDate,
    required this.link,
    required this.tags,
    this.isTop = false,
    this.isCollected = false,
  });
}
