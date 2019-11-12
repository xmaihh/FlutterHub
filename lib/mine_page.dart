import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

import 'pages/home/wallet_page.dart';

class MinePage extends StatefulWidget {
  final String _result;

  MinePage(this._result);

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
          SingleChildScrollView(
            //防止bottom overflowed by xxx PIXELS
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 120.0,
              ),
              child: Column(
                children: <Widget>[
                  _getSettingWidget(const EdgeInsets.only(top: 10),
                      GroovinMaterialIcons.wallet, '我的资产'),
                  _getSettingWidget(const EdgeInsets.only(),
                      GroovinMaterialIcons.raspberrypi, '安全中心'),
                  _getSettingWidget(const EdgeInsets.only(),
                      GroovinMaterialIcons.clipboard_text, '申诉列表'),
                  _getSettingWidget(const EdgeInsets.only(),
                      GroovinMaterialIcons.account_multiple, '客服咨询'),
                  _getSettingWidget(const EdgeInsets.only(top: 8),
                      GroovinMaterialIcons.credit_card, '绑定银行卡'),
                  _getSettingWidget(const EdgeInsets.only(top: 8),
                      GroovinMaterialIcons.settings_box, '设置'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 个人信息
  _getMineWidget(BuildContext context) {
    Map<String, dynamic> user = json.decode(widget._result);

    var name = user['email'];
    var index = name.indexOf('@');
    var strName = name.substring(0, name.indexOf('@'));

    return Container(
      height: ScreenUtil.getInstance().setHeight(76),
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 10),
                child: CircleAvatar(
                  //头像半径
                  radius: ScreenUtil.getInstance().setWidth(30),
                  //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      strName,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(18),
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      user['password'],
                      style: TextStyle(
                          height: 2.0,
                          fontSize: ScreenUtil.getInstance().setSp(14),
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 10),
            child: Icon(
              GroovinMaterialIcons.chevron_right,
              size: ScreenUtil.getInstance().setWidth(30),
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
      height: ScreenUtil.getInstance().setHeight(70),
      padding: const EdgeInsets.only(top: 10),
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => WalletPage()));
              },
              child: _singleItemWidget('理财计划', 'assets/images/pocket.png'),
            ),
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
          width: ScreenUtil.getInstance().setWidth(30),
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.grey[900],
              height: 1.5,
              fontSize: ScreenUtil.getInstance().setSp(14),
              fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  /// 设置菜单项
  _getSettingWidget(EdgeInsetsGeometry margin, IconData img, String text) {
    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().setHeight(50),
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
                  size: ScreenUtil.getInstance().setWidth(24),
                  color: Colors.blueAccent[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style:
                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(14)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Icon(
              GroovinMaterialIcons.chevron_right,
              size: ScreenUtil.getInstance().setWidth(30),
              color: Colors.grey[500],
            ),
          )
        ],
      ),
    );
  }
}
