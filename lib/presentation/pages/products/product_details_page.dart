// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';
import 'package:zona0_apk/config/helpers/show_image.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/router/router_path.dart';

import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({
    super.key,
    required this.productId,
  }) {
    product = AppData.allProducts
        .firstWhere((element) => element.id.toString() == productId);
  }

  final String productId;
  late Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        body: NestedScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            body: _ProductDetailsView(context),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: CustomIconButton(
                      icon: Icons.arrow_back_ios_outlined,
                      onPressed: () => context.pop()),
                  // title: const Text('Nombre barbero'),
                  actions: [
                    if (widget.product.discount > 0)
                      CustomBadge(label: "-${widget.product.discount}%"),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                  // centerTitle: true,
                  // pinned: true,
                  onStretchTrigger: () async {},
                  stretchTriggerOffset: 50.0,
                  expandedHeight: size.height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Center(
                      child: ImageAndName(context),
                    ),
                  ),
                ),
              ];
            }),
        floatingActionButton: widget.product.cantInCart <= 0
            ? BounceInUp(
                child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      SnackBarGI.showWithLottie(context,
                          lottiePath: LottiesPath.add_cart,
                          text: AppLocalizations.of(context)!.addCart);
                    },
                    child: const Icon(Icons.add_shopping_cart_outlined)),
              )
            : null);
  }

  Widget ImageAndName(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final color = Theme.of(context).colorScheme;
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                ShowImage.fromAsset(
                    context: context,
                    imagePath: widget.product.image,
                    heroTag: HeroTags.productId(widget.productId));
              },
              child: Hero(
                tag: HeroTags.productId(widget.productId),
                child: SizedBox(
                    height: size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(widget.product.image),
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                      ),
                    )),
              ),
            ),
            SizedBox(
                child: Text(widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${widget.product.realPrice.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: color.primary)),
                if (widget.product.discount > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('\$${widget.product.price.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(decoration: TextDecoration.lineThrough)),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _ProductDetailsView(BuildContext context) {
    final category = AppData.categoryList
        .firstWhere((element) => element.id == widget.product.category);
    final similarProducts = AppData.allProducts
        .where((p) => (p.category == widget.product.category &&
            p.id != widget.product.id))
        .toList();
    return SingleChildScrollView(
      child: FadeInUp(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("${AppLocalizations.of(context)!.marca}:"),
                        subtitle: Text(widget.product.brand),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title:
                            Text("${AppLocalizations.of(context)!.categoria}:"),
                        subtitle: Text(category.name),
                        trailing: Image.asset(category.image,
                            width: 120, height: 120, fit: BoxFit.contain),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title:
                            Text("${AppLocalizations.of(context)!.detalles}:"),
                        subtitle: Text(widget.product.description),
                      ),
                    ],
                  )),
            ),
            if (similarProducts.isNotEmpty) const SizedBox(height: 16),
            if (similarProducts.isNotEmpty)
              ProductsHorizontalListView(
                  title: AppLocalizations.of(context)!.productosSimilares,
                  products: similarProducts,
                  onTapProduct: (product) {
                    context.replace(
                        RouterPath.PRODUCT_DETAIL_PAGE(product.id.toString()));
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease);
                  }),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
