import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  /// 记录购买/出售按钮状态
  bool _isBuy = true;
  Color _buyColor = Colors.blueAccent[200];
  Color _buyTextColor = Colors.white;
  Color _saleColor = Colors.white;
  Color _saleTextColor = Colors.blueAccent[200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: _buyColor,
              textColor: _buyTextColor,
              child: Text(
                "购买",
              ),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.blueAccent[200])),
              onPressed: () {
                setState(() {
                  _isBuy = true;
                  _buyColor = _isBuy ? Colors.blueAccent[200] : Colors.white;
                  _buyTextColor =
                      _isBuy ? Colors.white : Colors.blueAccent[200];
                  _saleColor = _isBuy ? Colors.white : Colors.blueAccent[200];
                  _saleTextColor =
                      _isBuy ? Colors.blueAccent[200] : Colors.white;
                });
              },
            ),
            RaisedButton(
              color: _saleColor,
              textColor: _saleTextColor,
              child: Text(
                "出售",
              ),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.blueAccent[200])),
              onPressed: () {
                setState(() {
                  _isBuy = false;
                  _buyColor = _isBuy ? Colors.blueAccent[200] : Colors.white;
                  _buyTextColor =
                      _isBuy ? Colors.white : Colors.blueAccent[200];
                  _saleColor = _isBuy ? Colors.white : Colors.blueAccent[200];
                  _saleTextColor =
                      _isBuy ? Colors.blueAccent[200] : Colors.white;
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[Expanded(
          child: Center(
            child: Image.asset('assets/images/empty.png'),
          ),
        )],
      ),
    );
  }
}
