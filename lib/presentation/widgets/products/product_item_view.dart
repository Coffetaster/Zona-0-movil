import 'package:flutter/material.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView(
      {Key? key,
      required this.id,
      required this.image,
      this.description = "",
      this.discountLevel = 0,
      this.imageAlignment = Alignment.center,
      this.onProductPressed})
      : super(key: key);

  final String id;
  final String image;
  final String description;
  final int discountLevel;
  final Alignment imageAlignment;
  final Function(String)? onProductPressed;

  @override
  Widget build(BuildContext context) {
    final priceValue = 4.99;
    final crossedValue = 5.89;
    return GestureDetector(
      onTap: () {
        onProductPressed?.call(id);
      },
      child: SizedBox(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: AssetImage("assets/imagen/"+image+".png"),
                    alignment: imageAlignment,
                    fit: BoxFit.cover,
                  )),
                  // child: Image.network('${product.image}',
                  //     alignment: imageAlignment, fit: BoxFit.cover)),
              if (discountLevel > 0)
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      " ON SALE ${discountLevel}% ",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.white,
                          backgroundColor: Colors.pink.shade100),
                    ))
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Marca',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleMedium),
                Text('Nombre',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyLarge),
                if (description.isNotEmpty == true)
                  Text('${description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 12, color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  // child: ColorIndicatorView(product: product),
                ),
                Row(
                  children: [
                    Text('$priceValue €',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade100)),
                    if (crossedValue != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('$crossedValue €',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    decoration: TextDecoration.lineThrough)),
                      ),
                  ],
                ),
                // RatingView(
                //     value: product.reviews?.rating?.toInt() ?? 0,
                //     reviewsCount: product.reviews?.count?.toInt() ?? 0),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}