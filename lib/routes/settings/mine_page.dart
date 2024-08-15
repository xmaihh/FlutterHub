import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/states/theme_state.dart';
import 'package:flutter_hub/utils/app_version.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../common/index.dart';
import '../../states/profile_state.dart';
import '../../utils/check_update.dart';
import '../../widgets/svg_circle_avatar.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final _authServer = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: <Widget>[
          _getMineWidget(context),
          _getSubMenuWidget(context),
          SingleChildScrollView(
            //防止bottom overflowed by xxx PIXELS
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 120.0,
              ),
              child: Column(
                children: <Widget>[
                  _getSettingWidget(context, const EdgeInsets.only(top: 10), Bootstrap.palette, '个性换肤', () => Navigator.pushNamed(context, Constants.themeRoutePath)),
                  _getSettingWidget(context, const EdgeInsets.only(), Bootstrap.translate, '多语言', () => Navigator.pushNamed(context, Constants.languageRoutePath)),
                  _getSettingWidget(context, const EdgeInsets.only(), Bootstrap.arrow_clockwise, '检查更新', () => checkUpdate(context, manualCheck: true)),
                  FutureBuilder(
                      future: getAppVersion(),
                      builder: (context, snapshot) {
                        return _getSettingWidget(context, const EdgeInsets.only(top: 8), Bootstrap.cc_circle, '开源许可', () => showLicensePage(context: context, applicationName: loc.app_name, applicationVersion: snapshot.data ?? ''));
                      }),
                  _getSettingWidget(context, const EdgeInsets.only(), Bootstrap.info_circle, '关于', () => Navigator.pushNamed(context, Constants.aboutRoutePath)),
                  FutureBuilder(
                      future: _authServer.isLoggedIn(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox.shrink();
                        } else if (snapshot.hasData && snapshot.data == true) {
                          return _getSettingWidget(context, const EdgeInsets.only(top: 8), Bootstrap.box_arrow_right, '退出登录');
                        } else {
                          return SizedBox.shrink(); // 不显示任何 widget
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: [
        Consumer<ThemeState>(builder: (context, themeState, _) {
          // 定义三个图标及其对应的状态
          IconData currentIcon;

          const lightIcon = Bootstrap.brightness_high;
          const darkIcon = Bootstrap.moon_stars;
          const systemIcon = Bootstrap.circle_half;

          // 根据当前的主题模式选择图标和提示文本
          if (themeState.themeMode == ThemeMode.light) {
            currentIcon = lightIcon;
          } else if (themeState.themeMode == ThemeMode.dark) {
            currentIcon = darkIcon;
          } else {
            currentIcon = systemIcon;
          }
          return IconButton(
            icon: Icon(currentIcon),
            onPressed: () {
              // 切换主题模式
              if (themeState.themeMode == ThemeMode.light) {
                themeState.setThemeMode(ThemeMode.dark);
              } else {
                themeState.setThemeMode(ThemeMode.light);
              }
            },
          );
        }),
        IconButton(
          icon: Icon(AntDesign.bug_outline),
          tooltip: 'Debug',
          onPressed: () => debugPrint('Debug button is pressed.'),
        ),
        IconButton(
          icon: Icon(AntDesign.setting_outline),
          tooltip: 'Settings',
          onPressed: () => debugPrint('Settings button is pressed.'),
        ),
      ],
    );
  }

  /// 个人信息
  _getMineWidget(BuildContext context) {
    late final _colorScheme = Theme.of(context).colorScheme;
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget? child) {
        return GestureDetector(
            onTap: () {},
            child: Container(
                height: 76,
                color: _colorScheme.surface,
                margin: const EdgeInsets.only(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          child: SvgCircleAvatar(
                            radius: 30,
                            svgAssetPath: 'assets/images/avatar.svg',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '你说什么大点声',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                              ),
                              Text(
                                '积分：18 排名 887711， 等级：3',
                                style: TextStyle(height: 2.0, fontSize: 14, fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 10),
                      child: Icon(
                        Bootstrap.chevron_right,
                        size: 24,
                      ),
                    )
                  ],
                )));
      },
    );
  }

  /// 二级菜单
  _getSubMenuWidget(BuildContext context) {
    late final _colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: _colorScheme.surfaceContainer,
      height: 70,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _singleItemWidget('消息', 'assets/images/nav_msg.svg'),
            flex: 1,
          ),
          Expanded(
            child: _singleItemWidget('待办', 'assets/images/nav_todo.svg'),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {},
              child: _singleItemWidget('收藏', 'assets/images/nav_favorite.svg'),
            ),
          ),
        ],
      ),
    );
  }

  /// 单个item///
  _singleItemWidget(String text, String img) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SvgPicture.asset(
          img,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        Text(
          text,
          style: TextStyle(height: 1.5, fontSize: 14, fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  /// 设置菜单项
  _getSettingWidget(BuildContext context, EdgeInsetsGeometry margin, IconData img, String text, [VoidCallback? onTap]) {
    late final _colorScheme = Theme.of(context).colorScheme;
    return InkWell(
        onTap: onTap,
        child: Container(
          color: _colorScheme.surfaceContainer,
          height: 50,
          margin: margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      img,
                      size: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  Bootstrap.chevron_right,
                  size: 24,
                ),
              )
            ],
          ),
        ));
  }

  /// 请求数据
  void _retrieveUserData() async {
    final _apiService = getIt<ApiService>();
    var res = await _apiService.retrieveUserData(context);
    Provider.of<UserModel>(context, listen: true).user = res.data;
  }
}
