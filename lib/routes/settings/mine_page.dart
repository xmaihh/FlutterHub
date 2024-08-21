import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/states/theme_state.dart';
import 'package:flutter_hub/utils/app_version.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../common/index.dart';
import '../../states/profile_state.dart';
import '../../utils/check_update.dart';

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
                  _getSettingWidget(context, const EdgeInsets.only(top: 10), Bootstrap.palette, loc.settings_mine_theme, () => Navigator.pushNamed(context, Constants.themeRoutePath)),
                  _getSettingWidget(context, const EdgeInsets.only(), Bootstrap.translate, loc.settings_mine_language, () => Navigator.pushNamed(context, Constants.languageRoutePath)),
                  _getSettingWidget(context, const EdgeInsets.only(), Bootstrap.arrow_clockwise, loc.settings_mine_update, () => checkUpdate(context, manualCheck: true)),
                  _getLicenseWidget(context),
                  _getSettingWidget(context, const EdgeInsets.only(), Bootstrap.info_circle, loc.settings_mine_about, () => Navigator.pushNamed(context, Constants.aboutRoutePath)),
                  _getLogoutWidget(context),
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
    late final loc = AppLocalizations.of(context);
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget? child) {
        return GestureDetector(
            onTap: () {
              if (!userModel.isLogin) {
                Navigator.of(context).pushNamed(Constants.loginRoutePath);
              }
            },
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
                          child: RandomAvatar(
                            userModel.user?.userInfo?.username ?? 'flutterhub',
                            height: 50,
                            width: 52,
                          ),
                          // SvgCircleAvatar(
                          //   radius: 30,
                          //   svgAssetPath: 'assets/images/avatar.svg',
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userModel.user?.userInfo?.username ?? loc.settings_mine_login_title,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                              ),
                              Text(
                                userModel.isLogin ? loc.settings_mine_login_subtitle_userinfo((userModel.user?.coinInfo?.coinCount ?? 0).toString(), (userModel.user?.coinInfo?.rank ?? 0).toString(), (userModel.user?.coinInfo?.level ?? 0).toString()) : loc.settings_mine_login_subtitle_default,
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
    late final loc = AppLocalizations.of(context);
    return Container(
      color: _colorScheme.surfaceContainer,
      height: 70,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _singleItemWidget(loc.settings_mine_menu_msg, 'imgs/nav_msg.svg', 0),
            flex: 1,
          ),
          Expanded(
            child: _singleItemWidget(loc.settings_mine_menu_todo, 'imgs/nav_todo.svg', 0),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {},
              child: _singleItemWidget(loc.settings_mine_menu_favorite, 'imgs/nav_favorite.svg', 0),
            ),
          ),
        ],
      ),
    );
  }

  /// 单个item///
  _singleItemWidget(String text, String img, int badge) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Badge(
            label: badge > 0 ? Text(badge.toString()) : null, // 仅当 badge > 0 时显示文本
            isLabelVisible: badge > 0,
            child: SvgPicture.asset(
              img,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            )),
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

  /// 开源许可
  _getLicenseWidget(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureBuilder(
        future: getAppVersion(),
        builder: (context, snapshot) {
          return _getSettingWidget(context, const EdgeInsets.only(top: 8), Bootstrap.cc_circle, loc.settings_mine_license, () => showLicensePage(context: context, applicationName: loc.app_name, applicationVersion: snapshot.data ?? ''));
        });
  }

  /// 退出登录
  _getLogoutWidget(BuildContext context) {
    late final loc = AppLocalizations.of(context);
    return Consumer<UserModel>(builder: (BuildContext context, UserModel value, Widget? child) {
      if (value.isLogin) {
        return FutureBuilder(
            future: _authServer.isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              } else if (snapshot.hasData && snapshot.data == true) {
                return _getSettingWidget(
                    context,
                    const EdgeInsets.only(top: 8),
                    Bootstrap.box_arrow_right,
                    loc.settings_mine_logout,
                    () => showDialog(
                          context: context,
                          builder: (context) {
                            //退出账号前先弹二次确认窗
                            return AlertDialog(
                              content: Text(loc.settings_mine_logout_tip),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(loc.cancel),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: Text(loc.yes),
                                  onPressed: () {
                                    //该赋值语句会触发MaterialApp rebuild
                                    Provider.of<UserModel>(context, listen: false).user = null;
                                    getIt<AuthService>().logout();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        ));
              } else {
                return SizedBox.shrink(); // 不显示任何 widget
              }
            });
      } else {
        return SizedBox.shrink();
      }
    });
  }

  /// 请求数据
  void _retrieveUserData() async {
    final _apiService = getIt<ApiService>();
    var res = await _apiService.retrieveUserData(context);
    Provider.of<UserModel>(context, listen: true).user = res?.data;
  }
}
