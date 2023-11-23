import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/product.dart';

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
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 3,
      child: Material(
        child: InkWell(
          onTap: () => onTap?.call(product.id.toString()),
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
                                color: Colors.red.shade400,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Text("-${product.discount}%",
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
                        Text('\$${product.realPrice}',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: color.secondary)),
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
                                        decoration:
                                            TextDecoration.lineThrough)),
                          ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text("Al carro"),
                      icon: Icon(Icons.add_shopping_cart_outlined),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
