import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/first_page.dart';
import 'package:flutter_app/mine_page.dart';
import 'package:flutter_app/order_page.dart';
import 'package:flutter_app/transfer_page.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [
    FirstPage(), // 首页
    TransferPage(), // 集市
    OrderPage(), // 订单
    MinePage(), // 我的
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        iconSize: 32,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        selectedItemColor: Colors.blueAccent[200],
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
              title: Text(
                "首页",
              ),
              activeIcon: Icon(
                GroovinMaterialIcons.home,
                color: Colors.blueAccent[200],
              ),
              icon: Icon(
                GroovinMaterialIcons.home,
                color: Colors.grey[600],
              )),
          BottomNavigationBarItem(
              title: Text(
                "集市",
              ),
              activeIcon: Icon(
                GroovinMaterialIcons.transfer,
                color: Colors.blueAccent[200],
              ),
              icon: Icon(
                GroovinMaterialIcons.transfer,
                color: Colors.grey[600],
              )),
          BottomNavigationBarItem(
              title: Text(
                "订单",
              ),
              activeIcon: Icon(
                GroovinMaterialIcons.pocket,
                color: Colors.blueAccent[200],
              ),
              icon: Icon(
                GroovinMaterialIcons.pocket,
                color: Colors.grey[600],
              )),
          BottomNavigationBarItem(
              title: Text(
                "我的",
              ),
              activeIcon: Icon(
                GroovinMaterialIcons.account,
                color: Colors.blueAccent[200],
              ),
              icon: Icon(
                GroovinMaterialIcons.account,
                color: Colors.grey[600],
              )),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
