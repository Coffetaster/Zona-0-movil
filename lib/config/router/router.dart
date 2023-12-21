import 'package:flutter/material.dart';
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
          key: state.pageKey, child: const SearchProductsPage()),
    ),

    //* Utils Pages
    GoRoute(
      path: RouterPath.UTILS_IMAGE_CROP_PAGE,
      pageBuilder: (context, state) {
        final originalPath = state.extra as String?;
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: ImageCropPage(originalPath: originalPath));
      },
    ),

    //* Notifications Pages
    GoRoute(
      path: RouterPath.NOTIFICATIONS_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const NotificationsPage()),
    ),

    //* Settings Pages
    GoRoute(
      path: RouterPath.SETTINGS_ABOUT_US_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const AboutUsPage()),
    ),

    //* Account Pages
    GoRoute(
      path: RouterPath.ACCOUNT_CHANGE_PASSWORD_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const ChangePasswordPage()),
    ),
    GoRoute(
      path: RouterPath.ACCOUNT_EDIT_DATA_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const AccountEditData()),
    ),

    //* Auth Pages
    GoRoute(
      path: RouterPath.AUTH_LOGIN_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const LoginPage()),
    ),

    GoRoute(
      path: RouterPath.AUTH_VERIFY_CODE_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const VerifyCodePage()),
    ),

    GoRoute(
      path: RouterPath.AUTH_PASSWORD_RESET_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const PasswordResetPage()),
    ),

    GoRoute(
      path: RouterPath.AUTH_PASSWORD_RESET_CONFIRM_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const PasswordResetConfirmPage()),
    ),

    GoRoute(
        path: RouterPath.AUTH_REGISTER_PAGE,
        pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
            key: state.pageKey, child: const RegisterPage()),
        routes: [
          GoRoute(
            path: RouterPath.AUTH_REGISTER_CLIENT_PAGE_PATH,
            pageBuilder: (context, state) =>
                RouterTransition.slideTransitionPage(
                    key: state.pageKey, child: const RegisterFormPage(isClient: true)),
          ),
          GoRoute(
            path: RouterPath.AUTH_REGISTER_COMPANY_PAGE_PATH,
            pageBuilder: (context, state) =>
                RouterTransition.slideTransitionPage(
                    key: state.pageKey, child: const RegisterFormPage(isClient: false)),
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
