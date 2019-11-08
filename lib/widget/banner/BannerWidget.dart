import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

const MAX_COUNT = 0x7fffffff;

/// BannerItem点击事件
typedef void OnBannerItemClick(int position, BannerItem entity);

/// 自定义ViewPage的每个页面显示
typedef Widget CustomBuild(int position, BannerItem entity);

class BannerItem {
  String itemImagePath;
  String textContext;
  Widget itemText;

  static BannerItem defaultBannerItem(String image, String text) {
    BannerItem item = new BannerItem();
    item.itemImagePath = image;
    Text textWidget = new Text(
      text,
      softWrap: true,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.white, fontSize: 12.0, decoration: TextDecoration.none),
    );

    item.itemText = textWidget;
    item.textContext = text;
    return item;
  }

  static BannerItem defaultSohoItem(String text) {
    BannerItem item = new BannerItem();
    item.itemImagePath = '';
    item.textContext = text;
    item.itemText = Text('');
    return item;
  }
}

///
/// Banner 开发主要使用 Flutter的PageView组件
///

class BannerWidget extends StatefulWidget {
  final double height;
  final List<BannerItem> datas;
  int duration;
  double pointRadius;
  Color selectedColor;
  Color unSelectedColor;
  Color textBackgroundColor;
  bool isHorizontal;

  OnBannerItemClick bannerItemClick;

  CustomBuild build;

  BannerWidget(this.height, this.datas,
      {Key key,
      this.duration = 5000,
      this.pointRadius = 3.0,
      this.selectedColor = Colors.red,
      this.unSelectedColor = Colors.white,
      this.textBackgroundColor = const Color(0x99000000),
      this.isHorizontal = true,
      this.bannerItemClick,
      this.build})
      : super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<BannerWidget> {
  Timer timer;
  int selectedIndex = 0;
  PageController _controller;

  @override
  void initState() {
    double current = widget.datas.length > 0
        ? (MAX_COUNT / 2) - ((MAX_COUNT / 2) % widget.datas.length)
        : 0.0;
    _controller = PageController(initialPage: current.toInt());
    _initPageAutoScroll();
    super.initState();
  }

  _initPageAutoScroll() {
    start();
  }

  @override
  void didUpdateWidget(BannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget **************-banner');
  }

  start() {
    stop();
    timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
      if (widget.datas.length > 0 &&
          _controller != null &&
          _controller.page != null) {
        _controller.animateToPage(_controller.page.toInt() + 1,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  stop() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Colors.black12,
      child: Stack(
        children: <Widget>[
          _getViewPager(),
          Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(6.0),
                color: widget.textBackgroundColor,
                child: _getBannerTextInfoWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getViewPager() {
    return PageView.builder(
      scrollDirection: widget.isHorizontal ? Axis.horizontal : Axis.vertical,
      onPageChanged: onPageChanged,
      controller: _controller,
      itemCount: widget.datas.length > 0 ? MAX_COUNT : 0,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              if (widget.bannerItemClick != null) {
                widget.bannerItemClick(
                    selectedIndex, widget.datas[selectedIndex]);
              }
            },
            child: widget.build == null

                ///            ?FadeInImage.memoryNetwork(
                ? FadeInImage.assetNetwork(
                    ///                    placeholder: kTransparentImage,  ///  透明图像
                    placeholder:
                        widget.datas[index % widget.datas.length].itemImagePath,

                    /// 占位图
                    image:
                        widget.datas[index % widget.datas.length].itemImagePath,
                    fit: BoxFit.cover,
                  )
                : widget.build(
                    index, widget.datas[index % widget.datas.length]));
      },
    );
  }

  Widget _getBannerTextInfoWidget() {
    if (widget.isHorizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _getSelectedIndexTextWidget(),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: _getBannerIndicator(),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _getSelectedIndexTextWidget(),
          IntrinsicWidth(
            child: Row(
              children: _getBannerIndicator(),
            ),
          ),
        ],
      );
    }
  }

  Widget _getSelectedIndexTextWidget() {
    return widget.datas.length > 0 && selectedIndex < widget.datas.length
        ? widget.datas[selectedIndex].itemText
        : Text('');
  }

  ///
  /// 绘制BannerIndicator
  ///
  List<Widget> _getBannerIndicator() {
    List<Widget> circle = [];
    for (var i = 0; i < widget.datas.length; i++) {
      circle.add(Container(
        margin: EdgeInsets.all(2.0),
        width: widget.pointRadius * 2,
        height: widget.pointRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIndex == i
              ? widget.selectedColor
              : widget.unSelectedColor,
        ),
      ));
    }

    return circle;
  }

  onPageChanged(index) {
    selectedIndex = index % widget.datas.length;
    setState(() {});
  }
}
