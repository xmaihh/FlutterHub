import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 取消返回键
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("订单"),
        bottom: TabBar(
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
          child: Image.asset( 'assets/empty.png'),
          ),
          Center(
            child: Image.asset( 'assets/empty.png'),
          ),
          Center(
            child: Image.asset( 'assets/empty.png'),
          ),
          Center(
            child: Image.asset( 'assets/empty.png'),
          ),
        ],
      ),
    );
  }
}
