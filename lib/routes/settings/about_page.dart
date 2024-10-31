import 'package:flutter/material.dart';
import 'package:flutter_hub/utils/check_update.dart';
import 'package:flutter_hub/utils/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/localization_intl.dart';
import '../../utils/app_version.dart';

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
    final lan = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lan.settings_about),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          // App Logo
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FlutterLogo(size: 100),
            ),
          ),
          const SizedBox(height: 20),
          // App Name
          Center(
            child: Text(
              lan.app_name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Version
          Center(
            child: Text(
              '${lan.settings_app_version} $version',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // List Items
          ListTile(leading: const Icon(Icons.system_update), title: Text(lan.settings_check_for_updates), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => checkUpdate(context, manualCheck: true)),
          ListTile(leading: const Icon(Icons.description), title: Text(lan.settings_app_license), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => showLicensePage(context: context, applicationName: lan.app_name, applicationVersion: version)),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(lan.settings_code),
            subtitle: const Text('GitHub'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => UrlLauncher.openUrl('https://github.com/xmaihh/FlutterHub'),
          ),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: Text(lan.settings_issues),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => UrlLauncher.openUrl('https://github.com/xmaihh/FlutterHub/issues'),
          ),
          const SizedBox(height: 40),
          // Copyright
          const Center(
            child: Text(
              '© 2024 flutter_hub',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
