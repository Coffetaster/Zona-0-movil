import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/extensions/ripple_extension.dart';
import 'package:zona0_apk/presentation/widgets/products/product_card_view.dart';
import 'package:zona0_apk/presentation/widgets/products/product_icon.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _icon(IconData icon, {required Color color}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).colorScheme.background,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _categoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  setState(() {
                    AppData.categoryList.forEach((item) {
                      item.isSelected = false;
                    });
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * .7,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: AppData.allProducts
            .map(
              (product) => ProductCardView(
              // (product) => ProductCard(
                product: product,
                onTap: (model) {
                // onSelected: (model) {
                  context.push(RouterPath.PRODUCT_DETAIL_PAGE);
                  // setState(() {
                  //   AppData.productList.forEach((item) {
                  //     item.isSelected = false;
                  //   });
                  //   model.isSelected = true;
                  // });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(100),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          const SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 210,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _search(),
            _categoryWidget(),
            _productWidget(),
          ],
        ),
      ),
    );
  }
}
