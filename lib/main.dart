import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/routes/settings/about_page.dart';
import 'package:flutter_hub/routes/home_page.dart';
import 'package:flutter_hub/routes/settings/language_page.dart';
import 'package:flutter_hub/routes/settings/theme_page.dart';
import 'package:flutter_hub/routes/user/login_page.dart';
import 'package:flutter_hub/states/profile_change_notifier.dart';
import 'package:flutter_hub/states/theme_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/global.dart';

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
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, ThemeModel themeModel, LocaleModel localeModel, Widget? child) {
          return MaterialApp(
            theme: ThemeData(
              // colorScheme: ColorScheme.fromSeed(seedColor: themeModel.theme),
              useMaterial3: true, // Optional: enables Material 3 design
              primaryColor: themeModel.theme, primarySwatch: themeModel.theme,
              colorScheme: const ColorScheme.light().copyWith(primary: themeModel.theme),
            ),
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
              "login": (context) => LoginPage(),
              "themes": (context) => const ThemeChangePage(),
              "language": (context) => const LanguagePage(),
              "about": (context) => AboutPage(),
            },
          );
        },
      ),
    );
  }
}
