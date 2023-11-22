import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/presentation/widgets/extensions/ripple_extension.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    Key? key,
    required this.product,
    this.imageAlignment = Alignment.bottomCenter,
    this.onTap,
  }) : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    final priceValue = product.price - (product.price * product.discount / 100);
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.5,
          height: size.height * 0.4,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    SizedBox(
                        height: size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage(product.image),
                            alignment: imageAlignment,
                            fit: BoxFit.cover,
                          ),
                        )),
                    if (product.discount > 0)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("DESCUENTO: ${product.discount}% ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    backgroundColor: color.primary)
                            // backgroundColor: AppTheme.darkPink)
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
                        style: Theme.of(context).textTheme.bodyMedium)),
                Row(
                  children: [
                    Text('\$$priceValue',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade100)),
                    // color: AppTheme.vividOrange)),
                    if (product.discount > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('\$${product.price}',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    decoration: TextDecoration.lineThrough)),
                      ),
                  ],
                ),
                FilledButton(onPressed: (){}, child: Text("Al carro"))
              ]),
        ),
      ),
    ).ripple(() {
      onTap?.call(product.id.toString());
    }, borderRadius: const BorderRadius.all(Radius.circular(20)));
  }
}
