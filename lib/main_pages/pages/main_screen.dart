import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration_presets.dart';
import 'package:vibration/vibration.dart';

import '../../routes/routes.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  static const List<String> routeNames = [
    RouteNames.addVisits,
    RouteNames.customerVisits,
    RouteNames.stats,
  ];

  void _onItemTapped(BuildContext context, int index) async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(preset: VibrationPreset.singleShortBuzz);
    }

    if (!context.mounted) return;
    context.goNamed(routeNames[index]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    int selectedIndex = 0;
    if (location.contains(RouteNames.customerVisits)) {
      selectedIndex = 1;
    } else if (location.contains(RouteNames.stats)) {
      selectedIndex = 2;
    }
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar),
            label: 'Add Visits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Customer Visits',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Stats'),
        ],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.disabledColor,
      ),
    );
  }
}
