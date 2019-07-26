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
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    var listitems = new List<String>.generate(300, (i) => "第$i行");
    return Scaffold(
      appBar: AppBar(
        title: Text('TabController'),
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
            Tab(
              text: '时政',
            ),
            Tab(
              text: '军事',
            ),
          ],
          controller: _tabController, //1
        ),
      ),
      drawer: _drawer,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(children: _items),
          ListView.builder(
              itemCount: listitems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.book),
                  title: Text('${listitems[index]}'),
                );
              }),
          ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('${listitems[index]}'),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  constraints: BoxConstraints.tightFor(height: 1),
                  color: Colors.black45,
                );
              },
              itemCount: listitems.length),
          GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              ListTile(
                title: Text('item1'),
              ),
              ListTile(
                title: Text('item2'),
              ),
              ListTile(
                title: Text('item3'),
              ),
              ListTile(
                title: Text('item4'),
              )
            ],
          ),
          PageView(
            onPageChanged: (index) {
              print('当前为第 $index 页');
            },
            children: <Widget>[
              ListTile(
                title: Text('第0页'),
                subtitle: Text('subtitle'),
              ),
              ListTile(
                title: Text('第1页'),
                subtitle: Text('subtitle'),
              ),
              ListTile(
                title: Text('第2页'),
                subtitle: Text('subtitle'),
              ),
            ],
          ),
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

  //实现ListView Item
  get _items => <Widget>[
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text('正标题'),
          subtitle: Text('副标题'),
        ),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text('正标题'),
          subtitle: Text('副标题'),
        ),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text('正标题'),
          subtitle: Text('副标题'),
        ),
      ];

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
        length: 4,
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
              Tab(
                text: '教育',
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
            Center(
              child: Text('教育'),
            ),
          ]),
        ));
  }
}
