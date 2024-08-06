import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/states/profile_change_notifier.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../common/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    final ThemeData theme = Theme.of(context);
    final lan = WanLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lan.app_name),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.person_sharp),
            ),
            label: 'Mine',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Constants.loginRoutePath);
                },
                child: Text("Login"),
              ),
            ),
          ),
        ),

        /// Mine page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(), //构建抽屉菜单头部
              Expanded(child: _buildMenus()), //构建功能菜单
            ],
          )),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget? child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                    child: value.isLogin
                        ? FlutterLogo(
                            size: 80,
                          )
                        : FlutterLogo(
                            size: 80,
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(builder: (BuildContext context, UserModel value, Widget? child) {
      var lan = WanLocalizations.of(context);
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(lan.settings_theme),
                  leading: const Icon(Icons.color_lens),
                  onTap: () => Navigator.pushNamed(context, Constants.themeRoutePath),
                ),
                ListTile(
                  title: Text(lan.settings_language),
                  leading: const Icon(Icons.language),
                  onTap: () => Navigator.pushNamed(context, Constants.languageRoutePath),
                ),
                ListTile(
                  title: Text(lan.settings_about),
                  leading: const Icon(Icons.info),
                  onTap: () => Navigator.pushNamed(context, Constants.aboutRoutePath),
                ),
                // 添加更多 ListTile 项目
              ],
            ),
          ),
          FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final version = snapshot.data!.version;
                  final buildNumber = snapshot.data!.buildNumber;
                  return ListTile(
                    title: Text(
                      "Version: $version+$buildNumber",
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return const SizedBox(); // Or a loading indicator
                }
              }),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          )
        ],
      );
    });
  }
}
