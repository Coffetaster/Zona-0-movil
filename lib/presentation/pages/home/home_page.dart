import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/helpers/show_image.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/views/views.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    ShoppingCartView(),
    WalletView(),
    SettingsView()
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //WillPopScope
    //para controlar cuando se de atras

    Future.delayed(const Duration(milliseconds: 0), () {
      if (pageController.hasClients) {
        pageController.animateToPage(
          widget.pageIndex,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 250),
        );
      }
    });

    return PopScope(
      canPop: widget.pageIndex == 0,
      onPopInvoked: (canPop) {
        if (!canPop) context.go(RouterPath.HOME_PAGE);
      },
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: SafeArea(
          child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              body: Stack(children: [
                PageView(
                  //para evitar que scroll horizontalmente
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: viewRoutes,
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomBottomNavigationBar(widget.pageIndex))
              ]),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  if (widget.pageIndex < 4)
                    Consumer(
                      builder: (context, ref, child) {
                        final accountState = ref.watch(accountProvider);

                        return SliverAppBar(
                          onStretchTrigger: () async {},
                          stretchTriggerOffset: 50.0,
                          expandedHeight: accountState.isLogin ? 100 : 60,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Center(
                              child: Container(
                                height: accountState.isLogin ? 100 : 60,
                                child: Row(
                                  children: <Widget>[
                                    accountState.isLogin
                                        ? Row(
                                            children: <Widget>[
                                              const SizedBox(width: 8),
                                              GestureDetector(
                                                onTap: () {
                                                  if (accountState
                                                      .imagePath.isNotEmpty) {
                                                    ShowImage.show(
                                                        context: context,
                                                        foto: accountState
                                                            .imagePath,
                                                        tag:
                                                            "ImageProfile1-${accountState.id}");
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Hero(
                                                    tag: "ImageProfile1-${accountState.id}",
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50),
                                                        child: WidgetsGI
                                                            .CacheImageNetworkGI(
                                                                accountState
                                                                    .imagePath,
                                                                placeholderPath:
                                                                    ImagesPath
                                                                        .user_placeholder
                                                                        .path,
                                                                width: 50,
                                                                height: 50,
                                                                fit: BoxFit
                                                                    .cover)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              // Text("Hola, "),
                                              Text(
                                                  '${AppLocalizations.of(context)!.bienvenido},\n${accountState.username}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ],
                                          )
                                        : CustomTextButton(
                                            label: AppLocalizations.of(context)!
                                                .autenticar,
                                            icon: Icons.login_rounded,
                                            onPressed: () => context.go(
                                                RouterPath.AUTH_LOGIN_PAGE)),
                                    const Spacer(),
                                    const ThemeChangeWidget(),
                                    if (accountState.isLogin)
                                      CustomIconButton(
                                          icon: Icons.notifications_outlined,
                                          badgeInfo: "15",
                                          onPressed: () {
                                            Utils.showSnackbarEnDesarrollo(
                                                context);
                                          }),
                                    CustomIconButton(
                                        icon: Icons.search_outlined,
                                        onPressed: () {
                                          context.push(RouterPath.SEARCH_PAGE);
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ];
              }),
        ),
      ),
    );
    // return PopScope(
    //   canPop: widget.pageIndex == 0,
    //   onPopInvoked: (canPop){
    //     if(!canPop) context.go(RouterPath.HOME_PAGE);
    //   },
    //   child: Scaffold(
    //     appBar: AppBar(toolbarHeight: 0),
    //     body: SafeArea(
    //       child: Material(
    //         color: Colors.transparent,
    //         child: Stack(children: [
    //           PageView(
    //             //para evitar que scroll horizontalmente
    //             physics: const NeverScrollableScrollPhysics(),
    //             controller: pageController,
    //             children: viewRoutes,
    //           ),
    //           Positioned(
    //             left: 0,
    //             right: 0,
    //             bottom: 0,
    //             child: CustomBottomNavigationBar(widget.pageIndex))
    //         ]),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget CustomBottomNavigationBar(int currentIndex) {
    final color = Theme.of(context).colorScheme;
    return FadeInUp(
      child: CurvedNavigationBar(
        index: currentIndex,
        height: 60.0,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        color: color.secondaryContainer,
        // color: color.primaryContainer,
        backgroundColor: Colors.transparent,
        // backgroundColor: color.background,
        items: const <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.list_alt_outlined, size: 30),
          Icon(Icons.shopping_cart_outlined, size: 30),
          Icon(Icons.wallet_outlined, size: 30),
          Icon(Icons.settings_outlined, size: 30),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(RouterPath.HOME_PAGE);
              break;
            case 1:
              context.go(RouterPath.CATEGORIES_PAGE);
              break;
            case 2:
              context.go(RouterPath.SHOPPING_CART_PAGE);
              break;
            case 3:
              context.go(RouterPath.WALLET_PAGE);
              break;
            case 4:
              context.go(RouterPath.SETTINGS_PAGE);
              break;
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
