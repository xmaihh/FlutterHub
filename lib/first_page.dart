import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/widget/banner/BannerWidget.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<BannerItem> bannerList = [];

  List<BannerItem> sohuList = [];

  @override
  void initState() {
    bannerList
      ..add(BannerItem.defaultBannerItem('assets/images/banner0.png', ''''''));
    bannerList
      ..add(BannerItem.defaultBannerItem('assets/images/banner1.png', ''''''));

    sohuList..add(BannerItem.defaultSohoItem('''系统升级维护'''));
    sohuList..add(BannerItem.defaultSohoItem('''交易平台正式上线'''));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            Icon(
//              GroovinMaterialIcons.qrcode_scan,
//              color: Colors.grey[900],
//            ),
//            Icon(
//              GroovinMaterialIcons.currency_btc,
//              color: Colors.grey[900],
//              size: 36,
//            ),
            Image.asset(
              'assets/images/scan.png',
              width: ScreenUtil.getInstance().setWidth(30),
              height: ScreenUtil.getInstance().setHeight(30),
              color: Colors.grey[900],
            ),
            Image.asset(
              'assets/images/collect.png',
              width: ScreenUtil.getInstance().setWidth(30),
              height: ScreenUtil.getInstance().setHeight(30),
              color: Colors.grey[900],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: BannerWidget(
              ScreenUtil.getInstance().setHeight(120.0),
              bannerList,
              unSelectedColor: Colors.white,
              selectedColor: Colors.redAccent[200],
              bannerItemClick: (pos, item) {
                /// TODO 执行点击Banner操作的方法
                print('第 $pos 个Banner点击了');
              },
              isHorizontal: true,
              textBackgroundColor: Colors.transparent,
            ),
            margin: const EdgeInsets.fromLTRB(8,8,8,8),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: BannerWidget(
              ScreenUtil.getInstance().setHeight(40),
              sohuList,
              bannerItemClick: (pos, item) {
                /// TODO 执行点击公告操作的方法
                print('第 $pos 个公告点击了');
              },
              unSelectedColor: Colors.transparent,
              selectedColor: Colors.transparent,
              textBackgroundColor: Colors.transparent,
              isHorizontal: false,
              build: _getNoticeWidget,
            ),
            margin: const EdgeInsets.fromLTRB(8,0,8,8),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: _getQuickTransferWidget(
                'assets/images/transfer0.png',
                '快速购买',
                Colors.redAccent[200],
                '诚信 即时 保障',
                Colors.grey[700],
                '我要购买',
                Colors.redAccent[200]),
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: _getQuickTransferWidget(
                'assets/images/transfer1.png',
                '快速出售',
                Colors.green[700],
                '实时 高效 安全',
                Colors.grey[700],
                '我要出售',
                Colors.green[700]),
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
            child: _getAboutWidget(),
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          ),
        ],
      ),
    );
  }

  /// 公告栏
  Widget _getNoticeWidget(int position, BannerItem entity) {
    return Container(
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Icon(
              GroovinMaterialIcons.access_point,
              color: Colors.blueAccent[200],
              size: ScreenUtil.getInstance().setHeight(20),
            ),
            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          ),
          Container(
            child: Text(
              '最新公告: ',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: ScreenUtil.getInstance().setSp(14),
                  fontWeight: FontWeight.bold),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          ),
          Container(
            child: Text(
              entity.textContext,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: ScreenUtil.getInstance().setSp(14),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  /// 快速购买<.-=-.>快速出售 == 快速交易
  ///

  Widget _getQuickTransferWidget(
      String img,
      String mainText,
      Color mainTextColor,
      String subText,
      Color subTextColor,
      String btnText,
      Color btnBG) {
    return Container(
      color: Colors.grey[100],
      height: ScreenUtil.getInstance().setHeight(90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  img,
                  width: ScreenUtil.getInstance().setWidth(40),
                  height: ScreenUtil.getInstance().setHeight(40),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        mainText,
                        style: TextStyle(
                            color: mainTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil.getInstance().setSp(16)),
                      ),
                      Text(
                        subText,
                        style: TextStyle(
                            height: 1.5,
                            color: subTextColor,
                            fontSize: ScreenUtil.getInstance().setSp(14),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text(
                  btnText,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(14),
                      color: Colors.white),
                ),
                color: btnBG,
                onPressed: () {},
                shape: StadiumBorder(side: BorderSide(color: btnBG)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 关于我们<.-=-.>新手指引
  Widget _getAboutWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildAbout(const EdgeInsets.only(right: 4), Colors.indigo[50],
              '关于我们', 'assets/images/about.png'),
        ),
        Expanded(
          flex: 1,
          child: _buildAbout(const EdgeInsets.only(left: 4), Colors.brown[50], '新手指引',
              'assets/images/guide.png'),
        )
      ],
    );
  }

  Widget _buildAbout(
      EdgeInsetsGeometry margin, Color bg, String text, String img) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(72),
      color: bg,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(16),
                  color: Colors.grey[800]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  img,
                  width: ScreenUtil.getInstance().setWidth(20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
