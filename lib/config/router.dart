import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:catchit/screens/detail/detail_screen.dart';
import 'package:catchit/screens/main/main_screen.dart';
import 'package:catchit/screens/onboarding/onboarding_scren.dart';
import 'package:catchit/screens/privacy/privacy_screen.dart';
import 'package:catchit/screens/splash/spalsh_screen.dart';
import 'package:catchit/screens/update/update_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:catchit/screens/history/history_screen.dart';

GoRouter baseRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/update',
      name: 'update',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const UpdateScreen(),
        );
      },
    ),
    GoRoute(
      path: '/privacy',
      name: 'privacy',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const PrivacyScreen(),
        );
      },
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) {
        return CupertinoPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const OnboardingScreen(),
        );
      },
    ),
    GoRoute(
      path: '/main',
      name: 'main',
      pageBuilder: (context, state) {
        FirebaseAnalytics.instance.setCurrentScreen(screenName: 'main Screen');

        return CupertinoPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const MainScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'detail/:',
          name: 'detail',
          pageBuilder: (context, state) {
            FirebaseAnalytics.instance
                .setCurrentScreen(screenName: 'detail screen');
            final data = state.extra;
            return CupertinoPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: DetailScreen(data: data as DetailEntity),
            );
          },
        ),
        GoRoute(
          path: 'history/:',
          name: 'history',
          pageBuilder: (context, state) {
            FirebaseAnalytics.instance
                .setCurrentScreen(screenName: 'history screen');

            return CupertinoPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: HistoryScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
