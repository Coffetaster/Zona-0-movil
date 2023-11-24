import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/layouts/layouts.dart';
import 'package:zona0_apk/presentation/pages/auth/login_page.dart';
import 'package:zona0_apk/presentation/pages/home/home_page.dart';
import 'package:zona0_apk/presentation/pages/test/product_detail.dart';
import 'package:zona0_apk/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/presentation/pages/test/wallet_page2.dart';

import 'router_path.dart';
import 'router_transition.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _authNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouterPath.INITIAL_PAGE,
  routes: [

    GoRoute(
      path: RouterPath.INITIAL_PAGE,
      redirect: (context, state) => RouterPath.HOME_PAGE,
    ),

    GoRoute(
      path: RouterPath.PRODUCT_DETAIL_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child:  ProductDetailPage()),
    ),

    //* Auth Pages
    GoRoute(
      path: RouterPath.LOGIN_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: LoginPage()),
    ),

    GoRoute(
      path: RouterPath.REGISTER_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: RegisterPage()),
    ),

    //* Home Pages
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
            path: RouterPath.CATEGORIES_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const CategoriesPage()),
          ),
          GoRoute(
            path: RouterPath.SEARCH_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: SearchPage()),
          ),
          GoRoute(
            path: RouterPath.SHOPPING_CART_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: ShoppingCartPage()),
          ),
          GoRoute(
            path: RouterPath.WALLET_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: WalletPage2()),
          ),
          GoRoute(
            path: RouterPath.SETTINGS_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const SettingsPage()),
          ),
        ]),
  ],
);
