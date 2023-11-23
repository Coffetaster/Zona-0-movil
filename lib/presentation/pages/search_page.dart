import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/products/product_item_view.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hint: "Buscar producto",
          prefixIcon: Icons.search_outlined,
        ),

        ListView.builder(
          itemCount: AppData.allProducts.length,
          itemBuilder: (_, index){
            return Placeholder();
            // return ProductItemView(AppData.allProducts[index]);
          }
        )
      ],
    );
  }
}