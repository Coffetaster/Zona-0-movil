import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/products/product_item_view.dart';
import 'package:zona0_apk/presentation/widgets/products/products_card_payment.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ShoppingCartView extends ConsumerStatefulWidget {
  const ShoppingCartView({super.key});

  @override
  ConsumerState<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends ConsumerState<ShoppingCartView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final accountState = ref.watch(accountProvider);
    //*si no login
    if (!accountState.isLogin) {
      return const NoLoginPage();
    }

    final products =
        AppData.allProducts.where((element) => element.cantInCart > 0).toList();

    if (products.isEmpty) {
      final size = MediaQuery.sizeOf(context);
      return SingleChildScrollView(
          child: FadeInUp(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTitle(AppLocalizations.of(context)!.miCarrito),
                        const Divider(height: 30),
                        ZoomIn(
                            child: Center(
                                child: Image.asset(
                                    ImagesPath.empty_cart.path,
                                    width: size.width * .75,
                                    height: size.width * .75,
                                    fit: BoxFit.contain)))
                      ]))));
    }

    return SingleChildScrollView(
      child: FadeInUp(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(AppLocalizations.of(context)!.miCarrito),
              const Divider(
                thickness: 1,
                height: 30,
              ),
              ...products
                  .map((e) => ProductItemView(product: e, canEdit: true)),
              const Divider(
                thickness: 1,
                height: 30,
              ),
              ProductsCardPayment(products: products),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: CustomFilledButton(
                          onPressed: () {
                            Utils.showSnackbarEnDesarrollo(context);
                          },
                          label: AppLocalizations.of(context)!.continuar))
                ],
              ),
              const SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
