import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main_pages/pages/pages.dart';
import 'routes.dart';

final routesProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier();
  return GoRouter(
    initialLocation: RouteNames.addVisits,
    refreshListenable: router,
    routes: router.routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  List<RouteBase> get routes => [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: RouteNames.addVisits,
          name: RouteNames.addVisits,
          builder: (context, state) => const AddVisitsScreen(),
        ),
        GoRoute(
          path: RouteNames.customerVisits,
          name: RouteNames.customerVisits,
          builder: (context, state) => CustomerVisitsScreen(),
        ),
        GoRoute(
          path: RouteNames.stats,
          name: RouteNames.stats,
          builder: (context, state) => const StatsScreen(),
        ),
      ],
    ),
  ];
}
