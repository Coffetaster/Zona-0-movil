import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
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
    final colorPrimary = Theme.of(context).colorScheme.primary;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Hero(
              tag: "text_form_search_productos",
              child: Container(
                clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: colorPrimary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.push(RouterPath.SEARCH_PAGE),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(Icons.search_outlined, color: colorPrimary),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.buscarProductos,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  )),
              // child: CustomTextFormField(
              //             hint: AppLocalizations.of(context)!.buscarProductos,
              //             prefixIcon: Icons.search_outlined,
              //           ),
            ),
          ),
          BannerSlideshow(promos: AppData.allPromos),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
