import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/entities/product.dart';

import 'product_card_view.dart';

class ProductsHorizontalListView extends StatefulWidget {

  final List<Product> products;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const ProductsHorizontalListView({super.key, required this.products, this.title, this.subtitle, this.loadNextPage});

  @override
  State<ProductsHorizontalListView> createState() => _ProductsHorizontalListViewState();
}

class _ProductsHorizontalListViewState extends State<ProductsHorizontalListView> {

  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if(scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title != null || widget.subtitle != null)
          _Title(title: widget.title, subtitle: widget.subtitle),

          SizedBox(
            height: 300,
            child: Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.products.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                  FadeInRight(child: ProductCardView(
                    product: widget.products[index],
                    onTap: (id){
                      context.push(RouterPath.PRODUCT_DETAIL_PAGE);
                    })),
              )
            ),
          ),


        ],
      )
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: null,
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}