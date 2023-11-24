import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/presentation/widgets/cards/custom_card.dart';

class ProductsCardPayment extends StatelessWidget {
  const ProductsCardPayment({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    double priceTotal = 0;
    products.forEach((p) => priceTotal += p.realPrice);
    return CustomCard(
      child: Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Productos:",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    Text(products.length.toString(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                  ],
                ),
                ...products.map((p) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            width: 200,
                            child: Text(
                                "- ${p.name} (x${p.cantInCart})")),
                        Text("\$${p.realPrice.toStringAsFixed(2)}"),
                      ],
                    )),
                const Divider(
                  thickness: 1,
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    Text("\$${priceTotal.toStringAsFixed(2)}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Mensajería",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    Text("\$50.00",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    Text("\$${(priceTotal + 50).toStringAsFixed(2)}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
