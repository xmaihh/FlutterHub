import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/routes/user/mine_page.dart';
import 'package:flutter_hub/states/profile_state.dart';
import 'package:flutter_hub/widgets/disappearing_navigation_rail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../common/index.dart';
import '../widgets/animated_floating_action_button.dart';
import '../widgets/animations.dart';
import '../widgets/disappearing_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface);
  late final _controller = AnimationController(duration: const Duration(milliseconds: 1000), reverseDuration: const Duration(milliseconds: 1250), value: 0, vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  int selectedIndex = 0;
  bool controllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward && status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse && status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Scaffold(
            drawer: MyDrawer(),
            bottomNavigationBar: DisappearingBottomNavigationBar(
              barAnimation: _barAnimation,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            // floatingActionButton: AnimatedFloatingActionButton(
            //   animation: _barAnimation,
            //   onPressed: () {},
            //   child: const Icon(Icons.add),
            // ),
            body: Row(
              children: [
                DisappearingNavigationRail(
                  railAnimation: _railAnimation,
                  railFabAnimation: _railFabAnimation,
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                Expanded(
                  child: <Widget>[
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
                    MinePage()
                  ][selectedIndex],
                ),
              ],
            ),
          );
        });
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
            color: Theme.of(context).colorScheme.primary,
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
