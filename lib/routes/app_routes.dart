import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/dashboard_screen/dashboard_screen.dart';
import '../presentation/vak_test_screen/vak_test_screen.dart';
import '../presentation/planner_screen/planner_screen.dart';
import '../widgets/app_scaffold.dart';

class AppRoutes {
  static const String initial = '/';
  static const String dashboardScreen = '/dashboard-screen';
  static const String vakTestScreen = '/vak-test-screen';
  static const String plannerScreen = '/planner-screen';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 280),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.dashboardScreen,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.vakTestScreen,
              builder: (context, state) => const VAKTestScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.plannerScreen,
              builder: (context, state) => const PlannerScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
