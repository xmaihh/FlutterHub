import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/common/constants.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/models/banner.dart' as hub;
import 'package:flutter_hub/models/index.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/widgets/empty_state.dart';
import 'package:flutter_hub/widgets/loading_indicator.dart';
import 'package:flutter_hub/widgets/searchbar_with_hotwords.dart';
import 'package:flutter_hub/widgets/show_toast.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<hub.Banner> banners = [];
  List<Article> articles = [];
  int currentPage = 0;

  bool loadingMore = false;
  bool refreshing = false;
  bool hasMoreData = true;
  bool showTop = false;
  final ScrollController _scrollController = ScrollController();
  final _apiServer = getIt<ApiService>();

  @override
  void initState() {
    super.initState();
    fetchBanners();
    fetchArticles(isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
      if (!loadingMore && !refreshing && hasMoreData) {
        fetchArticles(isRefresh: false);
      }
      if (_scrollController.offset < 200 && showTop) {
        setState(() {
          showTop = false;
        });
      } else if (_scrollController.offset >= 200 && !showTop) {
        setState(() {
          showTop = true;
        });
      }
    }
  }

  Future<void> fetchBanners() async {
    ResponseListModel<hub.Banner>? res = await _apiServer.fetchBanners(context);
    if (res?.data != null) {
      setState(() {
        banners
          ..clear()
          ..addAll(res?.data ?? []);
      });
    }
  }

  Future<void> fetchArticles({required bool isRefresh}) async {
    if (isRefresh) {
      if (refreshing) return;
      setState(() {
        refreshing = true;
      });
    } else {
      if (loadingMore) return;
      setState(() {
        loadingMore = true;
      });
    }

    try {
      if (isRefresh) {
        currentPage = 0;
        articles.clear();
        ResponseListModel<Article>? res = await _apiServer.fetchTopArticles(context, useCache: !isRefresh);
        if (res?.data != null) {
          res?.data?.forEach((article) {
            article.top = true;
            debugPrint('置顶: ${article.title}');
          });
          articles = res?.data ?? [];
        }
      }

      List<Article> newArticles = [];
      ResponseModel<PaginationModel<Article>>? res = await _apiServer.fetchArticles(currentPage, context, useCache: !isRefresh);
      if (res?.data != null) {
        setState(() {
          newArticles = res?.data?.datas ?? [];
          hasMoreData = !(res?.data?.over == true);
        });
      }

      setState(() {
        articles.addAll(newArticles);

        if (hasMoreData) {
          currentPage++;
        }
      });
    } finally {
      setState(() {
        if (isRefresh) {
          refreshing = false;
        } else {
          loadingMore = false;
        }
      });
    }
  }

  Future<bool> _toggleCollection(int articleId, bool isCollecting) async {
    ResponseModel? res;
    if (isCollecting) {
      res = await _apiServer.collect(articleId, context);
      if (res?.errorCode == 0) {
        showToast(AppLocalizations.of(context).home_page_added_to_favorites);
      }
    } else {
      res = await _apiServer.uncollect(articleId, context);
      if (res?.errorCode == 0) {
        showToast(AppLocalizations.of(context).home_page_favorite_removed);
      }
    }

    if (res?.errorCode == 0) {
      return true;
    } else {
      showToast("${res?.errorMsg}${res?.errorCode}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          await fetchBanners();
          await fetchArticles(isRefresh: true);
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(padding: EdgeInsets.all(16), child: SearchBarWithHotWords()),
            ),
            // const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
            SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: _buildBanner())),
            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
              child: Text(
                AppLocalizations.of(context).home_page_latest_articles,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
            _buildArticleList(),
            // 空状态显示
            SliverToBoxAdapter(
              child: articles.isEmpty && !refreshing ? EmptyStateWidget(message: '') : Container(height: 0),
            )
          ],
        ),
      )),
      floatingActionButton: showTop
          ? IconButton(
              onPressed: () {
                _scrollController.animateTo(0, duration: Duration(milliseconds: 1500), curve: Curves.easeInOut);
                setState(() {
                  showTop = false;
                });
              },
              icon: Icon(
                Bootstrap.arrow_up_circle_fill,
                size: 40,
              ))
          : null,
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
        autoPlayAnimationDuration: Duration(milliseconds: 900),
        viewportFraction: 0.8,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Constants.articleRoutePath, arguments: {'url': banner.url, 'title': banner.title});
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
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
                    padding: const EdgeInsets.all(8.0),
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
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildArticleList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == articles.length) {
            // 只在加载更多时显示底部加载指示器
            return loadingMore && hasMoreData ? LoadingIndicator() : Container(height: 0);
          }
          return _buildArticleItem(articles[index]);
        },
        childCount: articles.length + (loadingMore && hasMoreData ? 1 : 0),
      ),
    );
  }

  Widget _buildArticleItem(Article article) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Constants.articleRoutePath, arguments: {'url': article.link, 'title': article.title, 'collect': article.collect});
        },
        child: Card(
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
                              if (article.top)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context).home_page_article_on_top,
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              Text(
                                article.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1, // 限制为一行
                                overflow: TextOverflow.ellipsis, // 超出长度时显示省略号
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            article.collect ? Icons.favorite : Icons.favorite_border,
                            color: article.collect ? Colors.red : Colors.grey,
                          ),
                          onPressed: () async {
                            // 先执行异步操作，根据结果来更新状态
                            if (article.collect) {
                              // 如果已经收藏，则尝试取消收藏
                              bool result = await _toggleCollection(article.id, false);
                              if (result) {
                                setState(() {
                                  article.collect = false;
                                });
                              }
                            } else {
                              // 如果未收藏，则尝试收藏
                              bool result = await _toggleCollection(article.id, true);
                              if (result) {
                                setState(() {
                                  article.collect = true;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: article.tags
                          .map((tag) => Chip(
                                label: Text(tag.name, style: TextStyle(fontSize: 12)),
                                backgroundColor: Colors.blue.withOpacity(0.1),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          article.author.isNotEmpty ? article.author : (article.shareUser.isNotEmpty ? article.shareUser : "Unknown"),
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
            ],
          ),
        ));
  }
}
