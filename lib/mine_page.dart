import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          _getMineWidget(context),
          _getSubMenuWidget(),
          _getSettingWidget(const EdgeInsets.only(top: 10),
              GroovinMaterialIcons.wallet, '我的资产'),
          _getSettingWidget(const EdgeInsets.only(), GroovinMaterialIcons.raspberrypi, '安全中心'),
          _getSettingWidget(const EdgeInsets.only(), GroovinMaterialIcons.clipboard_text, '申诉列表'),
          _getSettingWidget(const EdgeInsets.only(), GroovinMaterialIcons.account_multiple, '客服咨询'),
          _getSettingWidget(const EdgeInsets.only(top: 8),
              GroovinMaterialIcons.credit_card, '绑定银行卡'),
          _getSettingWidget(const EdgeInsets.only(top: 8),
              GroovinMaterialIcons.settings_box, '设置'),
        ],
      ),
    );
  }

  /// 个人信息
  _getMineWidget(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 14,bottom: 10),
                child: CircleAvatar(
                  //头像半径
                  radius: 36,
                  //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14,bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '登录/注册',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '立即登录可查看更多信息',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14,bottom: 10),
            child: Icon(
              GroovinMaterialIcons.chevron_right,
              size: 32,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  /// 二级菜单
  _getSubMenuWidget() {
    return Container(
      color: Colors.white,
      height: 80,
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _singleItemWidget('扫码', 'assets/images/scan.png'),
            flex: 1,
          ),
          Expanded(
            child: _singleItemWidget('收款码', 'assets/images/collect.png'),
            flex: 1,
          ),
          Expanded(
            child: _singleItemWidget('理财计划', 'assets/images/pocket.png'),
            flex: 1,
          ),
        ],
      ),
    );
  }

  /// 单个item///
  _singleItemWidget(String text, String img) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          img,
          width: 36,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.grey[900],
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  /// 设置菜单项
  _getSettingWidget(EdgeInsetsGeometry margin, IconData img, String text) {
    return Container(
      color: Colors.white,
      height: 50,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  img,
                  size: 26,
                  color: Colors.blueAccent[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(text),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              GroovinMaterialIcons.chevron_right,
              size: 32,
              color: Colors.grey[500],
            ),
          )
        ],
      ),
    );
  }
}
