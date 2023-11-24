import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/categories/category_chip.dart';
import 'package:zona0_apk/presentation/widgets/products/products_horizontal_listview.dart';
import 'package:zona0_apk/presentation/widgets/slideshows/banner_slideshow.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogin = true;
    return CustomScrollView(slivers: [
      //* toolbar
      SliverToBoxAdapter(
        child: Container(
          height: isLogin ? 100 : 60,
          child: Row(
            children: <Widget>[
              isLogin
                  ? Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => context.go(RouterPath.AUTH_LOGIN_PAGE),
                          child: const CircleAvatar(
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundImage:
                                AssetImage('assets/imagen/avatar.jpg'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Text("Hola, "),
                        Text('Hola,\nJohn Doe',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleMedium)
                      ],
                    )
                  : CustomTextButton(
                      label: "Autenticar",
                      icon: Icons.login_rounded,
                      onPressed: () => context.go(RouterPath.AUTH_LOGIN_PAGE)),
              const Spacer(),
              const ThemeChangeWidget(),
              if (isLogin)
                CustomIconButton(
                    icon: Icons.notifications_outlined,
                    badgeInfo: "15",
                    onPressed: () {}),
              CustomIconButton(
                  icon: Icons.search_outlined,
                  onPressed: () {
                    context.push(RouterPath.SEARCH_PAGE);
                  }),
            ],
          ),
        ),
      ),

      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            BannerSlideshow(promos: AppData.allPromos),
            _categoryWidget(context),
            ProductsHorizontalListView(
                products: AppData.allProducts
                    .where((element) => element.category == 1)
                    .toList()),
            ProductsHorizontalListView(
                title: "En descuento",
                subtitle: "Consíguelo ya",
                products:
                    AppData.allProducts.where((p) => p.discount > 0).toList()),
            ProductsHorizontalListView(
                title: "Populares", products: AppData.allProducts..shuffle()),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1)),
    ]);
  }

  Widget _categoryWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
}
