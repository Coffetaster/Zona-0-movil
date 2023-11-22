import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/layouts/layouts.dart';
import 'package:zona0_apk/presentation/pages/home/home_page.dart';
import 'package:zona0_apk/presentation/pages/home/mainPage.dart';
import 'package:zona0_apk/presentation/pages/home/product_detail.dart';
import 'package:zona0_apk/presentation/pages/home/shopping_cart_page.dart';
import 'package:zona0_apk/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';

import 'router_path.dart';
import 'router_transition.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _authNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouterPath.INITIAL_PAGE,
  routes: [
    // GoRoute(
    //   path: RouterPath.HOME_PAGE,
    //   pageBuilder: (context, state) =>
    //     RouterTransition.fadeTransitionPage(
    //       key: state.pageKey, child:  HomePage()),
    // ),
    // GoRoute(
    //   path: RouterPath.PRODUCT_DETAIL_PAGE,
    //   pageBuilder: (context, state) =>
    //     RouterTransition.fadeTransitionPage(
    //       key: state.pageKey, child:  ProductDetailPage()),
    // ),

    GoRoute(
      path: RouterPath.INITIAL_PAGE,
      redirect: (context, state) => RouterPath.HOME_PAGE,
    ),

    //MainPages
    ShellRoute(
        navigatorKey: _mainNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: RouterPath.HOME_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const HomePage()),
          ),
          GoRoute(
            path: RouterPath.FAVORITES_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: MyHomePage()),
          ),
          GoRoute(
            path: RouterPath.WALLET_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const WalletPage()),
          ),
          GoRoute(
            path: RouterPath.SETTINGS_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const ShoppingCartPage()),
          ),
        ]),
  ],
);
