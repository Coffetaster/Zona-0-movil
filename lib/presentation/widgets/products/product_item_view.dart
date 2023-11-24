import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView({Key? key, required this.product, this.onTap})
      : super(key: key);

  final Product product;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 1,
        child: Material(
            child: InkWell(
                onTap: () => onTap?.call(product.id.toString()),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 140,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
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
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.brand,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text(product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                if (product.description.isNotEmpty)
                                  Text('${product.description}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                Row(
                                  children: [
                                    Text(
                                        '\$${product.realPrice.toStringAsFixed(2)}',
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            softWrap: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          product.cantInCart <= 0
                              ? CustomIconButton(
                                  iconButtonType: IconButtonType.filledTonal,
                                  icon: Icons.add_shopping_cart_outlined,
                                  onPressed: () {},
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CustomIconButton(
                                      iconButtonType:
                                          IconButtonType.filledTonal,
                                      icon: Icons.add_outlined,
                                      onPressed: () {},
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
                                      iconButtonType:
                                          IconButtonType.filledTonal,
                                      icon: Icons.horizontal_rule_outlined,
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                        ]),
                  ),
                ))));
  }
}
