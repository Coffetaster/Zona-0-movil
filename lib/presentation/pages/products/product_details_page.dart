// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';
import 'package:zona0_apk/config/helpers/show_image.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';

import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({
    Key? key,
    required this.productId,
  }) : super(key: key){
    product = AppData.allProducts.firstWhere((element) => element.id.toString() == productId);
  }

  final String productId;
  late Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: NestedScrollView(
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
                  if (product.discount > 0)
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppTheme.borderRadius),
                      child: Container(
                        color: color.primary,
                        // color: Colors.red.shade400,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Text(
                              "-${product.discount}%",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white)
                              // backgroundColor: AppTheme.darkPink)
                              ),
                        ),
                      ),
                    ),
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
      floatingActionButton: product.cantInCart <= 0
          ? BounceInUp(
              child: FloatingActionButton(
                heroTag: null,
                  onPressed: () {
                    SnackBarGI.showWithLottie(context,
                          lottiePath: LottiesPath.add_cart,
                          text: AppLocalizations.of(context)!.addCart);
                  },
                  child: Icon(Icons.add_shopping_cart_outlined)),
            )
          : null
    );
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
              onTap: (){
                ShowImage.show(
                    context: context,
                    foto: product.image,
                    tag: "ProductId-$productId",
                    isAssets: true);
              },
              child: Hero(
                tag: "ProductId-$productId",
                child: SizedBox(
                    height: size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(product.image),
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                      ),
                    )),
              ),
            ),
            SizedBox(
                child: Text(product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${product.realPrice.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: color.primary)),
                if (product.discount > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('\$${product.price.toStringAsFixed(2)}',
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
        .firstWhere((element) => element.id == product.category);
    return SingleChildScrollView(
      child: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              CustomCard(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("${AppLocalizations.of(context)!.marca}:"),
                        subtitle: Text(product.brand),
                      ),
                    ],
                  )),
              CustomCard(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("${AppLocalizations.of(context)!.categoria}:"),
                        subtitle: Text(category.name),
                        trailing: Image.asset(category.image),
                      ),
                    ],
                  )),
              CustomCard(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("${AppLocalizations.of(context)!.detalles}:"),
                        subtitle: Text(product.description),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
