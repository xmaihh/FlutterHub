import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/routes/home/home_page.dart';
import 'package:flutter_hub/routes/settings/mine_page.dart';
import 'package:flutter_hub/states/profile_state.dart';
import 'package:flutter_hub/widgets/disappearing_navigation_rail.dart';
import 'package:flutter_hub/widgets/show_toast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../common/index.dart';
import '../models/index.dart';
import '../services/index.dart';
import '../widgets/animations.dart';
import '../widgets/disappearing_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface);
  late final _controller = AnimationController(duration: const Duration(milliseconds: 1000), reverseDuration: const Duration(milliseconds: 1250), value: 0, vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);
  final _authService = getIt<AuthService>();
  final _apiService = getIt<ApiService>();
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
                    HomePage(),
                    /// Mine page
                    MinePage(),
                  ][selectedIndex],
                ),
              ],
            ),
          );
        });
  }
}
