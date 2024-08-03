import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:provider/provider.dart';

import '../../common/global.dart';
import '../../states/profile_change_notifier.dart';

class ThemeChangePage extends StatelessWidget {
  const ThemeChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WanLocalizations.of(context).settings_theme),
      ),
      body: ListView(
        //显示主题色块
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: () {
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context, listen: false).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     final themeState = Provider.of<ThemeState>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('主题设置')),
//       body: Column(
//         children: [
//           ListTile(
//             title: Text('主题模式'),
//             trailing: DropdownButton<ThemeMode>(
//               value: themeState.themeMode,
//               items: ThemeMode.values.map((mode) {
//                 return DropdownMenuItem(
//                   value: mode,
//                   child: Text(mode.toString().split('.').last),
//                 );
//               }).toList(),
//               onChanged: (mode) {
//                 if (mode != null) themeState.setThemeMode(mode);
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: ThemeState.themeColors.map((color) {
//                 return GestureDetector(
//                   onTap: () => themeState.setThemeColor(color),
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: color,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: themeState.primaryColor == color
//                             ? Colors.white
//                             : Colors.transparent,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
