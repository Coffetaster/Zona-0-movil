import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/layouts/layouts.dart';
import 'package:zona0_apk/presentation/pages/auth/login_page.dart';
import 'package:zona0_apk/presentation/pages/home/home_page.dart';
import 'package:zona0_apk/presentation/pages/test/money_transfer_page.dart';
import 'package:zona0_apk/presentation/pages/test/product_detail.dart';
import 'package:zona0_apk/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/presentation/pages/home/wallet_page.dart';

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

    //* Wallet pages
    GoRoute(
      path: RouterPath.WALLET_TRANSFER_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child:  MoneyTransferPage()),
    ),

    //* Auth Pages
    GoRoute(
      path: RouterPath.AUTH_LOGIN_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const LoginPage()),
    ),

    GoRoute(
      path: RouterPath.AUTH_REGISTER_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const RegisterPage()),
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
                    key: state.pageKey, child: const SearchPage()),
          ),
          GoRoute(
            path: RouterPath.SHOPPING_CART_PAGE,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const ShoppingCartPage()),
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
                    key: state.pageKey, child: const SettingsPage()),
          ),
        ]),
  ],
);
