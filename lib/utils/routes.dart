import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_point/view/landing_view/privacy_policy.dart';
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
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: 'privacy_policy',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const PrivacyPolicy(),
          ),
        ),
        GoRoute(
          path: 'index',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const Index(),
          ),
        ),
      ]
    ),
  ],
);
