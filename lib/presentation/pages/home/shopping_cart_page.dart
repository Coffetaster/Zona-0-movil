import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/products/product_item_view.dart';
import 'package:zona0_apk/presentation/widgets/products/products_card_payment.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products =
        AppData.allProducts.where((element) => element.cantInCart > 0).toList();
    return SingleChildScrollView(
      child: FadeInUp(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Mi carrito",
                  style: Theme.of(context).textTheme.titleLarge),
              const Divider(
                thickness: 1,
                height: 30,
              ),
              ...products.map((e) => ProductItemView(product: e)),
              const Divider(
                thickness: 1,
                height: 30,
              ),
              ProductsCardPayment(products: products),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomFilledButton(onPressed: () {}, label: "Continuar"),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
