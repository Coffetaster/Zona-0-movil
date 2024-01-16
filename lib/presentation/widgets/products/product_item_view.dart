import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView({Key? key, required this.product, this.onTap, this.canEdit = false})
      : super(key: key);

  final Product product;
  final Function(String)? onTap;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return CustomCard(
        onTap: () => onTap?.call(product.id.toString()),
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 160,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage(product.image),
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          )),
                      // child: Image.network('${product.image}',
                      //     alignment: imageAlignment, fit: BoxFit.cover)),
                      if (product.discount > 0)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CustomBadge(label: "-${product.discount}%"),
                        )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.brand,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyLarge),
                      if (product.description.isNotEmpty)
                        Text('${product.description}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 12, color: color.secondary)),
                      Row(
                        children: [
                          Text('\$${product.realPrice.toStringAsFixed(2)}',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              softWrap: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: color.primary)),
                          if (product.discount > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough)),
                            ),
                        ],
                      ),

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
                ),
                if(product.cantInCart > 0 && canEdit)
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomIconButton(
                            iconButtonType: IconButtonType.filledTonal,
                            icon: Icons.delete_outline,
                            onPressed: () {
                              Utils.showSnackbarEnDesarrollo(context);
                            },
                          ),
                          CustomIconButton(
                            iconButtonType: IconButtonType.filledTonal,
                            icon: Icons.horizontal_rule_outlined,
                            onPressed: () {
                              Utils.showSnackbarEnDesarrollo(context);
                            },
                          ),
                          CustomTextButton(
                            label: "x${product.cantInCart}",
                            onPressed: (){
                              Utils.showSnackbarEnDesarrollo(context);
                            },
                          ),
                          CustomIconButton(
                            iconButtonType: IconButtonType.filledTonal,
                            icon: Icons.add_outlined,
                            onPressed: () {
                              Utils.showSnackbarEnDesarrollo(context);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ));
  }
}
