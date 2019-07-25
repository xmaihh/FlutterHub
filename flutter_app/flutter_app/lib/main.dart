import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义TabController'),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(
              text: '热点',
            ),
            Tab(
              text: '体育',
            ),
            Tab(
              text: '科技',
            ),
          ],
          controller: _tabController, //1
        ),
      ),
      drawer: _drawer,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(child: Text('热点')),
          Center(child: Text('体育')),
          Center(child: Text('科技')),
        ],
      ),
    );
  }

  //实现Drawer示例
  get _drawer => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: Icon(Icons.account_circle),
              accountName: Text('example'),
              accountEmail: Text('example@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('电话'),
            ),
            ListTile(
              leading: Icon(Icons.local_post_office),
              title: Text('邮件'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

//*TabBar
class MyTabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('DefaultTabController示例'),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                text: '热点',
              ),
              Tab(
                text: '体育',
              ),
              Tab(
                text: '科技',
              ),
            ]),
          ),
          body: TabBarView(children: <Widget>[
            Center(
              child: Text('热点'),
            ),
            Center(
              child: Text('体育'),
            ),
            Center(
              child: Text('科技'),
            ),
          ]),
        ));
  }
}
