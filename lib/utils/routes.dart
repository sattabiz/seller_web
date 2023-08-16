import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view/index.dart';
import '../view/landing_view/landing_view.dart';
import '../view/login_view/login_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LandingView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        GoRoute(
          path: 'index',
          builder: (BuildContext context, GoRouterState state) {
            return const Index();
          },
        ),
      ]
    ),
  ],
);
