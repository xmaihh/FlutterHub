import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/states/profile_state.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.primary;
    var localeModel = Provider.of<LocaleModel>(context);
    var lan = AppLocalizations.of(context);
    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing:
            localeModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          // 此行代码会通知MaterialApp重新build
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lan.settings_language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文", "zh_CN"),
          _buildLanguageItem("Endlish", "en_US"),
          _buildLanguageItem(lan.settings_language_auto, null),
        ],
      ),
    );
  }
}
