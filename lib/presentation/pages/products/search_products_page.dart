import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/products/product_item_view.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class SearchProductsPage extends StatelessWidget {
  const SearchProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final products = AppData.allProducts..shuffle();
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Column(
          children: [
            Hero(
              tag: HeroTags.textFormSearchProductos,
              child: CustomTextFormField(
                hint: AppLocalizations.of(context)!.buscarProductos,
                prefixIcon: Icons.search_outlined,
              ),
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
          
          ],
              ),
        ),
      ),
    );
  }
}