import 'package:flutter/material.dart';

import '../transitions/nav_rail_transition.dart';
import 'animations.dart';

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
    super.key,
    required this.railAnimation, // Add this parameter
    required this.railFabAnimation, // Add this parameter
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final RailAnimation railAnimation; // Add this variable
  final RailFabAnimation railFabAnimation; // Add this variable
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    late final _colorScheme = Theme.of(context).colorScheme;
    // Modify from here ...
    // return LayoutBuilder(builder: (context, constraints) {
      return NavRailTransition(
          animation: railAnimation,
          backgroundColor: Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface),
          child: NavigationRail(
            selectedIndex: selectedIndex,
            backgroundColor: Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface),
            indicatorColor: _colorScheme.primary,
            // extended: constraints.maxWidth >= 600,
            onDestinationSelected: onDestinationSelected,
            leading: Column(
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.menu),
                // ),
                // const SizedBox(height: 8),
                // AnimatedFloatingActionButton(
                //   animation: railFabAnimation,
                //   elevation: 0,
                //   onPressed: () {},
                //   child: const Icon(Icons.add),
                // ),
              ],
            ),
            groupAlignment: -0.85,
            destinations: [
              NavigationRailDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Badge(
                  child: Icon(Icons.person_outline_sharp),
                ),
                selectedIcon: Badge(
                  child: Icon(Icons.person_sharp),
                ),
                label: Text('Mine'),
              ),
            ],
          ));
    // });
  }
}
