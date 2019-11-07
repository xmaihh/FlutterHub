import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  /// 选中下标
  int _currentIndex = 0;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() => _onTabChanged());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      this.setState(() {
        _currentIndex = _tabController.index;
      });

      ///TODO 执行获取页面数据
      print('当前页index: $_currentIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 取消返回键
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "订单",
          style: TextStyle(color: Colors.grey[900]),
        ),
        bottom: TabBar(
//          isScrollable: true,
          indicatorColor: Colors.blueAccent[200],
          labelColor: Colors.grey[600],
          unselectedLabelColor: Colors.grey[500],
          tabs: <Widget>[
            Tab(
              text: "待付款",
            ),
            Tab(
              text: "已付款",
            ),
            Tab(
              text: "已放币",
            ),
            Tab(
              text: "已取消",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Image.asset('assets/images/empty.png'),
          ),
          Center(
            child: Image.asset('assets/images/empty.png'),
          ),
          Center(
            child: Image.asset('assets/images/empty.png'),
          ),
          Center(
            child: Image.asset('assets/images/empty.png'),
          ),
        ],
      ),
    );
  }
}
