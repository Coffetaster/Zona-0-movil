import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  final Product product;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return CustomCard(
      padding: const EdgeInsets.all(8.0),
      onTap: () => onTap?.call(product.id.toString()),
      child: SizedBox(
        width: size.width * 0.45,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(product.image),
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                        ),
                      )),
                  if (product.discount > 0)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadius),
                        child: Container(
                          color: color.primary,
                          // color: Colors.red.shade400,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                                "-${product.discount}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)
                                // backgroundColor: AppTheme.darkPink)
                                ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                  child: Text(product.brand,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.titleMedium)),
              SizedBox(
                  child: Text(product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyLarge)),
              if (product.discount > 0)
                Text('\$${product.price.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(decoration: TextDecoration.lineThrough)),
              Text('\$${product.realPrice.toStringAsFixed(2)}',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: color.primary)),
              if (product.cantInCart <= 0) const Spacer(),
              if (product.cantInCart <= 0)
                SizedBox(
                  width: double.infinity,
                  child: CustomFilledButton(
                    filledButtonType: FilledButtonType.tonal,
                    icon: Icons.add_shopping_cart_outlined,
                    label: AppLocalizations.of(context)!.loQuiero,
                    onPressed: () {
                      // SnackbarGI.showWithIcon(context, icon: Icons.add_shopping_cart_outlined, text: "Agregado al carrito");
                      SnackBarGI.showWithLottie(context,
                          lottiePath: LottiesPath.add_cart,
                          text: AppLocalizations.of(context)!.addCart);
                    },
                  ),
                )
            ]),
      ),
    );
  }
}
