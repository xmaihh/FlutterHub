import 'package:flutter/material.dart';
import 'package:flutter_hub/common/index.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/routes/home_page.dart';
import 'package:flutter_hub/routes/settings/about_page.dart';
import 'package:flutter_hub/routes/settings/language_page.dart';
import 'package:flutter_hub/routes/settings/theme_page.dart';
import 'package:flutter_hub/routes/user/login_page.dart';
import 'package:flutter_hub/routes/user/signup_page.dart';
import 'package:flutter_hub/states/profile_state.dart';
import 'package:flutter_hub/states/theme_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeState()),
      ],
      child: Consumer2<ThemeState, LocaleModel>(
        builder: (BuildContext context, ThemeState themeState, LocaleModel localeModel, Widget? child) {
          return MaterialApp(
            theme: themeState.lightTheme,
            darkTheme: themeState.darkTheme,
            themeMode: themeState.themeMode,
            onGenerateTitle: (context) {
              return WanLocalizations.of(context).app_name;
            },
            home: const HomePage(),
            locale: localeModel.getLocale(),
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('zh', 'CN'),
            ],
            localizationsDelegates: const [
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              WanLocalizationsDelegate(),
            ],
            localeResolutionCallback: (_locale, supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();
              } else {
                //跟随系统
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale = _locale!;
                } else {
                  //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                  locale = const Locale('en', 'US');
                }
                return locale;
              }
            },
            // 注册路由表
            routes: <String, WidgetBuilder>{
              Constants.loginRoutePath: (context) => LoginPage(),
              Constants.signupRoutePath: (context) => SignupPage(),
              Constants.themeRoutePath: (context) => const ThemeChangePage(),
              Constants.languageRoutePath: (context) => const LanguagePage(),
              Constants.aboutRoutePath: (context) => AboutPage(),
            },
          );
        },
      ),
    );
  }
}
