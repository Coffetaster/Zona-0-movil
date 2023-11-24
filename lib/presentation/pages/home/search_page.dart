import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/products/product_item_view.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final products = AppData.allProducts..shuffle();
    return Column(
      children: [
        CustomTextFormField(
          hint: "Buscar producto",
          prefixIcon: Icons.search_outlined,
        ),

        Expanded(
          child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          itemBuilder: (_, index){
            return ProductItemView(product: products[index]);
            // return ProductItemView(AppData.allProducts[index]);
          }
                  ),
        ),
        SizedBox(
          height: 20,
        )

      ],
    );
  }
}