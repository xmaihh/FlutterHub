import 'package:flutter/material.dart';

import '../transitions/bottom_bar_transition.dart';
import 'animations.dart';

class DisappearingBottomNavigationBar extends StatelessWidget {
  const DisappearingBottomNavigationBar({
    super.key,
    required this.barAnimation, // Add this parameter
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final BarAnimation barAnimation; // Add this variable
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    late final _colorScheme = Theme.of(context).colorScheme;
    // Modify from here...
    return BottomBarTransition(
      animation: barAnimation,
      backgroundColor: Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface),
      child: NavigationBar(
        elevation: 0,
        indicatorColor: _colorScheme.primary,
        backgroundColor: Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.person_outline_sharp),
            ),
            selectedIcon: Badge(
              child: Icon(Icons.person_sharp),
            ),
            label: 'Mine',
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );
    // ... to here.
  }
}
