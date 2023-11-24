import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';

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
      onTap: () => onTap?.call(product.id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.45,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    SizedBox(
                        height: size.height * 0.20,
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
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: color.primary,
                            // color: Colors.red.shade400,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Text(
                                  "-${product.discount.toStringAsFixed(2)}%",
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
                Row(
                  children: [
                    Text('\$${product.realPrice.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: color.primary)),
                    if (product.discount > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('\$${product.price.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    decoration:
                                        TextDecoration.lineThrough)),
                      ),
                  ],
                ),
                product.cantInCart <= 0
                    ? SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          icon: Icons.add_shopping_cart_outlined,
                          label: "Al carro",
                          onPressed: (){},
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomIconButton(
                            iconButtonType: IconButtonType.filledTonal,
                            icon: Icons.horizontal_rule_outlined,
                            onPressed: (){},
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13)),
                                color: Theme.of(context)
                                    .colorScheme
                                    .background),
                            child: Text("x${product.cantInCart}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    )),
                          ),
                          CustomIconButton(
                            iconButtonType: IconButtonType.filledTonal,
                            icon: Icons.add_outlined,
                            onPressed: (){},
                          ),
                        ],
                      )
              ]),
        ),
      ),
    );
  }
}
