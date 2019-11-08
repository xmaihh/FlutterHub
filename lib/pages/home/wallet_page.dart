import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletPage  extends StatefulWidget{
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人收款'),
      ),
      body: Center(
        child: QrImage(
          data: "这里是需要生成二维码的数据",
          size: ScreenUtil.getInstance().setWidth(200.0),
          version: QrVersions.auto,
          gapless: false,
        ),
      ),
    );
  }

}