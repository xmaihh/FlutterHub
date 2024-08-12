import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/states/theme_state.dart';
import 'package:provider/provider.dart';

class ThemeChangePage extends StatelessWidget {
  const ThemeChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings_theme),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).settings_theme),
            trailing: DropdownButton<ThemeMode>(
              value: themeState.themeMode,
              items: ThemeMode.values.map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(mode.toString().split('.').last),
                );
              }).toList(),
              onChanged: (mode) {
                if (mode != null) themeState.setThemeMode(mode);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: ThemeState.themeColors.map((color) {
                return GestureDetector(
                  onTap: () => themeState.setThemeColor(color),
                  child: Container(
                    width: themeState.primaryColor == color ? 60 : 36,
                    height: themeState.primaryColor == color ? 60 : 36,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
