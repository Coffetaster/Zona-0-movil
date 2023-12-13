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
    return CustomScrollView(
      slivers: [
      //* toolbar
      SliverToBoxAdapter(
        child: Container(
          height: AppTheme.isLogin ? 100 : 60,
          child: Row(
            children: <Widget>[
              AppTheme.isLogin
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
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    )
                  : CustomTextButton(
                      label: AppLocalizations.of(context)!.autenticar,
                      icon: Icons.login_rounded,
                      onPressed: () => context.go(RouterPath.AUTH_LOGIN_PAGE)),
              const Spacer(),
              const ThemeChangeWidget(),
              if (AppTheme.isLogin)
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
                title: AppLocalizations.of(context)!.populares, products: AppData.allProducts..shuffle()),
            const SizedBox(height: 80),
          ],
        );
      }, childCount: 1)),
    ]);
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
