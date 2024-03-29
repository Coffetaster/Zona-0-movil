import 'package:flutter/material.dart';
import 'package:zona0_apk/config/router/router_nav/router_nav.dart';
import 'package:zona0_apk/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/presentation/pages/test/doble_page.dart';

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

    //* Wallet Pages
    GoRoute(
      path: RouterPath.WALLET_RECEIVE_OSP_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey, child: const ReceiveOSPPage());
      },
    ),
    GoRoute(
      path: RouterPath.WALLET_SEND_OSP_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey, child: const SendOSPPage());
      },
    ),
    GoRoute(
      path: RouterPath.WALLET_BANKING_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey, child: BankingPage());
      },
    ),
    GoRoute(
      path: RouterPath.WALLET_REDEEM_CODE_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey, child: const RedeemCodePage());
      },
    ),
    GoRoute(
      path: RouterPath.WALLET_PLAY_GAME_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey, child: const PlayGamePage());
      },
    ),
    GoRoute(
      path: RouterPath.WALLET_DONATE_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey, child: const DonatePage());
      },
    ),
    GoRoute(
      path: RouterPath.WALLET_RECEIVE_ITEM_DATA_PAGE_PATH,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        final canEdit = state.pathParameters['canEdit'] ?? '1';
        return RouterTransition.slideTransitionPage(
            key: state.pageKey,
            child: ReceiveItemDataPage(
              id: id,
              canEdit: canEdit == '1',
              transactionReceived:
                  context.navParseExtra(state.extra).ReceiveItemDataPage,
            ));
      },
    ),

    //* Utils Pages
    GoRoute(
      path: RouterPath.UTILS_IMAGE_CROP_PAGE,
      pageBuilder: (context, state) {
        final originalPath = state.extra as String?;
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey,
            child: ImageCropPage(originalPath: originalPath));
      },
    ),
    GoRoute(
      path: RouterPath.UTILS_QR_SCANNER_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: QrScannerPage());
      },
    ),

    //* Notifications Pages
    GoRoute(
      path: RouterPath.NOTIFICATIONS_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const NotificationsPage()),
    ),

    //* Institutions Pages
    GoRoute(
      path: RouterPath.INSTITUTIONS_DETAILS_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey,
            child: InstitutionDetailsPage(
                institution:
                    context.navParseExtra(state.extra).InstitutionDetailsPage));
      },
    ),

    //* Test Pages
    GoRoute(
      path: RouterPath.TEST_DOBLE_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: DoblePage()),
    ),

    //* Settings Pages
    GoRoute(
      path: RouterPath.SETTINGS_ABOUT_US_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const AboutUsPage()),
    ),
    GoRoute(
      path: RouterPath.SETTINGS_MANAGE_CARD_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: ManageCardPage()),
    ),

    //* Account Pages
    GoRoute(
      path: RouterPath.ACCOUNT_CHANGE_PASSWORD_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const ChangePasswordPage()),
    ),

    //* Users Pages
    GoRoute(
      path: RouterPath.USERS_EDIT_DATA_PAGE,
      pageBuilder: (context, state) {
        final otherHeroTag = state.extra;
        return RouterTransition.slideTransitionPage(
            key: state.pageKey,
            child: UserEditDataPage(
                otherHeroTag: (otherHeroTag != null && otherHeroTag is String)
                    ? otherHeroTag
                    : ''));
      },
    ),
    GoRoute(
      path: RouterPath.USERS_PROFILE_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.slideTransitionPage(
            key: state.pageKey,
            child: ProfilePage(
                user: context.navParseExtra(state.extra).ProfilePage_User,
                userImageTag:
                    context.navParseExtra(state.extra).ProfilePage_UserImageTag));
      },
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
                    key: state.pageKey,
                    child: const RegisterFormPage(isClient: true)),
          ),
          GoRoute(
            path: RouterPath.AUTH_REGISTER_COMPANY_PAGE_PATH,
            pageBuilder: (context, state) =>
                RouterTransition.slideTransitionPage(
                    key: state.pageKey,
                    child: const RegisterFormPage(isClient: false)),
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
