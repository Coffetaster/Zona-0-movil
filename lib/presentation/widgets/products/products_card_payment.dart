import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/cards/custom_card.dart';

class ProductsCardPayment extends StatelessWidget {
  const ProductsCardPayment({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    double priceTotal = 0;
    products.forEach((p) => priceTotal += p.realPrice);
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${AppLocalizations.of(context)!.productos}:",
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
                Text(AppLocalizations.of(context)!.subtotal,
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
                Text(AppLocalizations.of(context)!.mensajeria,
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
                Text(AppLocalizations.of(context)!.total,
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
      ),
    );
  }
}
