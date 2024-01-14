import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          BannerSlideshow(promos: AppData.allPromos),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomTitle(AppLocalizations.of(context)!.categorias),
          ),
          _categoryWidget(context),
          ProductsHorizontalListView(
              products: AppData.allProducts
                  .where((element) => element.category == 1)
                  .toList()),
          const SizedBox(
            height: 16,
          ),
          ProductsHorizontalListView(
              title: AppLocalizations.of(context)!.enDescuento,
              subtitle: AppLocalizations.of(context)!.consigueloYa,
              products:
                  AppData.allProducts.where((p) => p.discount > 0).toList()),
          const SizedBox(
            height: 16,
          ),
          ProductsHorizontalListView(
              title: AppLocalizations.of(context)!.populares,
              products: AppData.allProducts..shuffle()),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _categoryWidget(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => CategoryChip(
                model: category,
                onSelected: (model) {},
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
