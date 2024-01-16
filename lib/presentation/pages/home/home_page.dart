import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/show_image.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/views/views.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;
  final scrollController = ScrollController();

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
    AppTheme.principalScrollController = scrollController;
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Future.delayed(const Duration(milliseconds: 0), () {
      if (pageController.hasClients) {
        pageController.animateToPage(
          widget.pageIndex,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 250),
        );
      }
    });

    final colorPrimary = Theme.of(context).colorScheme.primary;

    return PopScope(
      canPop: widget.pageIndex == 0,
      onPopInvoked: (canPop) {
        if (!canPop) {
          scrollController.animateTo(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
          if (AppTheme.isPanelOpen) {
            AppTheme.panelController.close();
          } else {
            context.go(RouterPath.HOME_PAGE);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        // appBar: widget.pageIndex == 0 ? AppBar(toolbarHeight: 0) : null,
        body: _homeBody(colorPrimary),
      ),
    );
  }

  Widget _homeBody(Color colorPrimary) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // statusBarColor: Colors.red, //i like transaparent :-)
        systemNavigationBarColor:
            context.secondaryContainer, // navigation bar color
        // statusBarIconBrightness: Brightness.dark, // status bar icons' color
        // systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
      ),
      child: SafeArea(
        child: NestedScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            body: Stack(children: [
              PageView(
                //para evitar que scroll horizontalmente
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: viewRoutes,
              ),
              _bottomNav()
            ]),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                if (widget.pageIndex < 4) _appBar(colorPrimary),
              ];
            }),
      ),
    );
  }

  Consumer _appBar(Color colorPrimary) {
    return Consumer(
      builder: (context, ref, child) {
        final accountState = ref.watch(accountProvider);
        return SliverAppBar(
          expandedHeight: widget.pageIndex == 0 ? 160 : 100,
          pinned: widget.pageIndex == 0,
          // snap: widget.pageIndex == 2,
          // floating: widget.pageIndex == 2,
          bottom: widget.pageIndex == 0
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Hero(
                      tag: HeroTags.textFormSearchProductos,
                      child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: colorPrimary,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppTheme.borderRadius),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => context.push(RouterPath.SEARCH_PAGE),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Icon(Icons.search_outlined,
                                      color: colorPrimary),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .buscarProductos,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                )
              : null,
          flexibleSpace: FlexibleSpaceBar(
            background: Center(
              child: Container(
                height: widget.pageIndex == 0 ? 160 : 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: colorPrimary.withOpacity(.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppTheme.borderRadius))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(ImagesPath.logo.path,
                                    height: 50, width: 50, fit: BoxFit.fill),
                                Text(
                                  AppLocalizations.of(context)!
                                      .nameApp
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          accountState.isLogin
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('${accountState.username}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        if (accountState.imagePath.isNotEmpty) {
                                          ShowImage.fromNetwork(
                                              context: context,
                                              imagePath: accountState.imagePath,
                                              heroTag: HeroTags.imageProfile1(
                                                  accountState.id));
                                        }
                                      },
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Hero(
                                          tag: HeroTags.imageProfile1(
                                              accountState.id),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child:
                                                  WidgetsGI.CacheImageNetworkGI(
                                                      accountState.imagePath,
                                                      placeholderPath:
                                                          ImagesPath
                                                              .pic_profile.path,
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                )
                              : CustomTextButton(
                                  label:
                                      AppLocalizations.of(context)!.autenticar,
                                  icon: Icons.login_rounded,
                                  onPressed: () =>
                                      context.go(RouterPath.AUTH_LOGIN_PAGE)),
                          if (accountState.isLogin)
                            CustomIconButton(
                                icon: Icons.notifications_outlined,
                                badgeInfo: "15",
                                onPressed: () {
                                  context.push(RouterPath.NOTIFICATIONS_PAGE);
                                }),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    if (widget.pageIndex == 0) const SizedBox(height: 60.0)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _bottomNav() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: _CustomBottomNavigationBar(widget.pageIndex));
  }

  Widget _CustomBottomNavigationBar(int currentIndex) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInUp(
      child: CurvedNavigationBar(
        index: currentIndex,
        height: 60.0,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        color: colorScheme.secondaryContainer,
        // color: color.primaryContainer,
        backgroundColor: Colors.transparent,
        // backgroundColor: color.background,
        items: <Widget>[
          const Icon(Icons.home_outlined, size: 30),
          const Icon(Icons.list_alt_outlined, size: 30),
          Badge(
              backgroundColor: colorScheme.tertiary,
              label: Text("7", style: TextStyle(color: colorScheme.onTertiary)),
              alignment: const Alignment(-.5, -.5),
              // alignment: const Alignment(.25, -.35),
              child: const Icon(Icons.shopping_cart_outlined, size: 30)),
          // Icon(Icons.shopping_cart_outlined, size: 30),
          const Icon(Icons.wallet_outlined, size: 30),
          const Icon(Icons.settings_outlined, size: 30),
        ],
        onTap: (index) {
          if (AppTheme.isPanelOpen) {
            AppTheme.panelController.close();
          }
          scrollController.animateTo(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
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
