import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/products/products_horizontal_listview.dart';
import 'package:zona0_apk/presentation/widgets/slideshows/banner_slideshow.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        titleSpacing: 0,
        centerTitle: false,
        // leading: Icon(
        //   Icons.movie_outlined,
        //   color: Theme.of(context).colorScheme.primary
        // ),
        title: Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Zona 0", style: Theme.of(context).textTheme.titleLarge),
        ),
        actions: [
          CustomIcon(
            icon: Icons.login_outlined,
          ),
        ],
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            BannerSlideshow(promos: AppData.allPromos),
            ProductsHorizontalListView(
                title: "De moda",
                subtitle: "Algo",
                products: AppData.allProducts),
            ProductsHorizontalListView(
                title: "De moda",
                subtitle: "Algo",
                products: AppData.allProducts),
            ProductsHorizontalListView(
                title: "De moda",
                subtitle: "Algo",
                products: AppData.allProducts),
            ProductsHorizontalListView(
                title: "De moda",
                subtitle: "Algo",
                products: AppData.allProducts),
            ProductsHorizontalListView(
                title: "De moda",
                subtitle: "Algo",
                products: AppData.allProducts),
            ProductsHorizontalListView(
                title: "De moda",
                subtitle: "Algo",
                products: AppData.allProducts),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1)),
    ]);
  }
}
