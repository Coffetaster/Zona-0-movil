import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ShoppingCartView extends ConsumerStatefulWidget {
  const ShoppingCartView({super.key});

  @override
  ConsumerState<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends ConsumerState<ShoppingCartView>
    with AutomaticKeepAliveClientMixin {
  // final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isLogin = ref.watch(accountProvider.select((value) => value.isLogin));
    //*si no login
    if (!isLogin) {
      return const NoLoginPage();
    }

    final products =
        AppData.allProducts.where((element) => element.cantInCart > 0).toList();

    final isPanelOpen = ref.watch(isPanelOpenProvider);

    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(AppTheme.borderRadius),
      topRight: Radius.circular(AppTheme.borderRadius),
    );

    return SlidingUpPanel(
      controller: AppTheme.panelController,
      color: context.background,
      minHeight: 150,
      parallaxEnabled: !isPanelOpen,
      maxHeight: context.height - 100 - 70,
      onPanelSlide: (position) {
        if (isPanelOpen && position < 0.95) {
          ref.read(isPanelOpenProvider.notifier).state = false;
        } else if (!isPanelOpen && position >= 0.95) {
          ref.read(isPanelOpenProvider.notifier).state = true;
        }
        if (AppTheme.isPrincipalScrollControllerActive &&
            AppTheme.principalScrollController!.position.pixels > 0) {
          // AppTheme.principalScrollController!.jumpTo(0);
          AppTheme.principalScrollController!.animateTo(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      },
      panelBuilder: (ScrollController sc) {
        if (!isPanelOpen && sc.hasClients && sc.position.pixels > 0) {
          sc.jumpTo(0);
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SingleChildScrollView(
            controller: sc,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (products.isEmpty) ZoomIn(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                              child: Image.asset(
                                  ImagesPath.empty_cart.path,
                                  width: context.width * .75,
                                  height: context.width * .75,
                                  fit: BoxFit.contain))),
                    ) else SizedBox(
                        width: double.infinity,
                        height: (184 * products.length).toDouble(),
                        child: AnimatedListGIWidget(
                          controller: AnimatedListGIController(),
                          physics: const NeverScrollableScrollPhysics(),
                          items: products,
                          builder: (context, index) {
                            return ProductItemView(
                                product: products[index], canEdit: true);
                          },
                        ),
                      ),
                const SizedBox(height: 80)
              ],
            ),
          ),
        );
      },
      collapsed: Container(
        decoration:
            BoxDecoration(color: context.secondary, borderRadius: radius),
        child: Center(
          child: Column(
            children: [
              ShakeY(
                duration: const Duration(milliseconds: 5000),
                infinite: true,
                from: 4,
                child: CustomIconButton(
                  icon: Icons.keyboard_arrow_up_outlined,
                  color: context.onSecondary,
                  onPressed: () {
                    AppTheme.panelController.open();
                  },
                ),
              ),
              Text(
                AppLocalizations.of(context)!.deslizaArribaCarrito,
                style: context.labelLarge.copyWith(color: context.onSecondary),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: isPanelOpen
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FadeIn(
                  child: CustomTitle(AppLocalizations.of(context)!.miCarrito),
                ),
              )
            : FadeIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      ProductsCardPayment(products: products),
                      const SizedBox(height: 8),
                      CustomFilledButton(
                          onPressed: () {
                            Utils.showSnackbarEnDesarrollo(context);
                          },
                          label: AppLocalizations.of(context)!.continuar),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
      ),
      borderRadius: isPanelOpen ? null : radius,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
