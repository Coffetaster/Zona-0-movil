import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/pages/test/money_transfer_page.dart';
import 'package:zona0_apk/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';

import 'router_path.dart';
import 'router_transition.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouterPath.INITIAL_PAGE,
  routes: [
    GoRoute(
      path: RouterPath.INITIAL_PAGE,
      redirect: (context, state) => RouterPath.HOME_PAGE,
    ),

    GoRoute(
      path: RouterPath.PRODUCT_DETAIL_PAGE_PATH,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: ProductDetailsPage(productId: id));
      },
    ),

    GoRoute(
      path: RouterPath.SEARCH_PAGE,
      pageBuilder: (context, state) => RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const SearchPage()),
    ),

    //* Wallet pages
    GoRoute(
      path: RouterPath.WALLET_TRANSFER_PAGE,
      pageBuilder: (context, state) => RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: MoneyTransferPage()),
    ),

    //* Auth Pages
    GoRoute(
      path: RouterPath.AUTH_LOGIN_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const LoginPage()),
    ),

    GoRoute(
        path: RouterPath.AUTH_REGISTER_PAGE,
        pageBuilder: (context, state) => RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: const RegisterPage()),
        routes: [
          GoRoute(
            path: RouterPath.AUTH_REGISTER_CLIENT_PAGE_PATH,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: RegisterClientPage()),
          ),
          GoRoute(
            path: RouterPath.AUTH_REGISTER_COMPANY_PAGE_PATH,
            pageBuilder: (context, state) =>
                RouterTransition.fadeTransitionPage(
                    key: state.pageKey, child: const RegisterCompanyPage()),
          ),
        ]),

    //* Home Pages
    GoRoute(
      path: RouterPath.HOME_PAGE_PATH,
      pageBuilder: (context, state) {
        final page = int.parse(state.pathParameters['page'] ?? '0') % 5;
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: HomePage(pageIndex: page));
      },
    ),
  ],
);
