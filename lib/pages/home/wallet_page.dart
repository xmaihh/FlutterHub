import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context); //返回
            },
            child: Icon(
              GroovinMaterialIcons.chevron_left,
              size: ScreenUtil.getInstance().setWidth(30),
              color: Colors.white,
            ),
          ),
          title: Text(
            '个人收款',
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(18)),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                width: double.infinity,
                height: ScreenUtil.getInstance().setHeight(300),
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        '我的钱包',
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        '收款二维码',
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(14),
                        ),
                      ),
                    ),
                    QrImage(
                      data: '这里是需要生成二维码的数据',
                      size: ScreenUtil.getInstance().setWidth(200.0),
                      version: QrVersions.auto,
                      gapless: false,
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              Container(
                color: Colors.white,
                height: ScreenUtil.getInstance().setHeight(50),
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Text(
                        '钱包ID: B568002504',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(16)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 复制到剪贴板
                        var data = ClipboardData(text: "B568002504");
                        Clipboard.setData(data);
                        Fluttertoast.showToast(
                            msg: "复制成功",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos:1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize:
                            ScreenUtil.getInstance().setSp(14));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Text(
                          '复制',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: ScreenUtil.getInstance().setSp(16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
