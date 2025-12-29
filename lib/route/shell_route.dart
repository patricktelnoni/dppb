import 'package:dppb/main.dart';
import 'package:dppb/view/auth/login_form.dart';
import 'package:dppb/view/home/dashboard.dart';
import 'package:dppb/view/posts/post_list.dart';
import 'package:dppb/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionANavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Return the widget that implements the custom shell (Navigation Bar)
        return MyHomePage(navigationShell: navigationShell,);
      },
      branches: [
        // First Tab
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const Dashboard(),
            ),
          ],
        ),
        // Second Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/post',
              builder: (context, state) => const PostList(),
            ),
          ],
        ),
        // Third Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/account',
              builder: (context, state) => const LoginForm(),
            ),
          ],
        ),
      ],
    ),
  ],
);
