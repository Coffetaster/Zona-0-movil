import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:zona0_apk/presentation/widgets/products/products_horizontal_listview.dart';
import 'package:zona0_apk/presentation/widgets/shared/custom_icon.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          titleSpacing: 0,
          centerTitle: false,
          // leading: Icon(
          //   Icons.movie_outlined,
          //   color: Theme.of(context).colorScheme.primary
          // ),
          title: Padding(padding: EdgeInsets.only(left: 12), child: Text(
            "Zona 0",
            style: Theme.of(context).textTheme.titleLarge
          ),),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  ProductsHorizontalListView(
                    title: "De moda",
                    subtitle: "Algo",
                    products: AppData.allProducts
                  ),
                  ProductsHorizontalListView(
                    title: "De moda",
                    subtitle: "Algo",
                    products: AppData.allProducts
                  ),
                  ProductsHorizontalListView(
                    title: "De moda",
                    subtitle: "Algo",
                    products: AppData.allProducts
                  ),
                  ProductsHorizontalListView(
                    title: "De moda",
                    subtitle: "Algo",
                    products: AppData.allProducts
                  ),
                  ProductsHorizontalListView(
                    title: "De moda",
                    subtitle: "Algo",
                    products: AppData.allProducts
                  ),
                  ProductsHorizontalListView(
                    title: "De moda",
                    subtitle: "Algo",
                    products: AppData.allProducts
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
            childCount: 1
          )
        ),
      ]
    );
  }
}