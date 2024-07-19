import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _children;

  void initData() {
    _children = [
      FirstPage(), // 首页
      MinePage(widget._result), // 我的
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter App name"), actions: [
        IconButton(
          icon: const Icon(Icons.sync),
          onPressed: () {},
        )
      ]),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        iconSize: 30,
        unselectedFontSize: 12.sp,
        selectedFontSize: 12.sp,
        selectedItemColor: Colors.blueAccent[200],
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
              title: Text(
                "首页",
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.blueAccent[200],
              ),
              icon: Icon(
                Icons.home,
                color: Colors.grey[600],
              )),
          BottomNavigationBarItem(
              title: Text(
                "Mine",
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.blueAccent[200],
              ),
              icon: Icon(
                Icons.person,
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
