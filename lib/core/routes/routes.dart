import 'dart:io';

import 'package:assessment/presentation/form_screen.dart';
import 'package:assessment/presentation/home_screen.dart';
import 'package:assessment/presentation/login_%20screen.dart';
import 'package:assessment/presentation/splash_screen.dart';
import 'package:assessment/utils/globle_variable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route names as constants
class MyRoutes {
  static GoRouter router = GoRouter(
    navigatorKey: GlobalVariable.globalScaffoldKey,
    initialLocation: SPLASH,
    routes: [
      animatedGoRoute(
        path: SPLASH,
        name: SPLASH,
        pageBuilder: (context, state) => const SplashScreen(),
      ),
      animatedGoRoute(
        path: LOGIN,
        name: LOGIN,
        pageBuilder: (context, state) => LoginScreen(),
      ),
      animatedGoRoute(
        path: DASHBOARD,
        name: DASHBOARD,
        pageBuilder: (context, state) => HomeScreen(),
      ),
      animatedGoRoute(
        path: FORMSCREEN,
        name: FORMSCREEN,
        pageBuilder: (context, state) => FormScreen(),
      ),
    ],
  );

  /// Route constants
  static const SPLASH = "/";
  static const LOGIN = "/login";
  static const FORMSCREEN = "/formscreen";

  static const DASHBOARD = "/dashboard";
}

GoRoute animatedGoRoute({
  required String path,
  required String name,
  ExitCallback? onExitPage,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
}) {
  return GoRoute(
    path: path,
    name: name,
    onExit: onExitPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 400),
      child: pageBuilder(context, state),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1.5, 0), end: Offset.zero).chain(
                  CurveTween(curve: Curves.bounceIn),
                ),
              ),
              child: child,
            );
          },
        );
}
