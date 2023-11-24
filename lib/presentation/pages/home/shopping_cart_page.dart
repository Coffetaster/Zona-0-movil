import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/products/product_item_view.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products =
        AppData.allProducts.where((element) => element.cantInCart > 0).toList();
    double totalPrice = 0;
    products.forEach((p) {
      totalPrice += p.realPrice;
    });
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text("Mi carrito", style: Theme.of(context).textTheme.titleLarge)),
            Divider(
              thickness: 1,
              height: 30,
            ),
            Column(
              children:
                  products.map((e) => ProductItemView(product: e)).toList(),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //       scrollDirection: Axis.vertical,
            //       itemCount: products.length,
            //       itemBuilder: (_, index) {
            //         return ProductItemView(product: products[index]);
            //         // return ProductItemView(AppData.allProducts[index]);
            //       }),
            // ),
            Divider(
              thickness: 1,
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${AppData.allProducts.where((e) => e.cantInCart > 0).length} Productos',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CustomFilledButton(onPressed: () {}, label: "Continuar"),
            ),

            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
