import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/app_version.dart';
import '../common/check_update.dart';
import '../l10n/localization_intl.dart';
import '../widgets/link_icon.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String version = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final getVersion = await getAppVersion();
    if (mounted) {
      setState(() {
        version = getVersion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lan = WanLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lan.settings_about),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(lan.settings_app_version),
            subtitle: Text(version),
          ),
          ListTile(title: Text(lan.settings_check_for_updates), onTap: () => checkUpdate(context, manualCheck: true)),
          ListTile(title: Text(lan.settings_app_license), onTap: () => showLicensePage(context: context, applicationName: lan.app_name, applicationVersion: version)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinkIcon(icon: IonIcons.logo_github, url: 'https://github.com/xmaihh/FlutterHub', mode: LaunchMode.externalApplication),
            ],
          ),
        ],
      ),
    );
  }
}
