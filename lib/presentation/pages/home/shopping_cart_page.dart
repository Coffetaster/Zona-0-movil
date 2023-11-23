import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/domain/entities/product.dart';
import 'package:zona0_apk/presentation/widgets/test/title_text.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  Widget _cartItems() {
    return Column(children: AppData.allProducts.where((e) => e.isliked).map((x) => _item(x)).toList());
  }

  Widget _item(Product model) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Image.asset(model.image, width: 75, height: 75),
                )
              ],
            ),
          ),
          Expanded(
              child: ListTile(
                  title: TitleText(
                    text: model.name,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      TitleText(
                        text: '\$ ',
                        // color: Colors.red.shade400,
                        fontSize: 12,
                      ),
                      TitleText(
                        text: model.price.toString(),
                        fontSize: 14,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      text: 'x${model.id}',
                      fontSize: 12,
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${AppData.allProducts.where((e) => e.isliked).length} Items',
          // color: Colors.grey.shade300,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${getPrice()}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width * .75,
        // width: AppTheme.fullWidth(context) * .75,
        child: TitleText(
          text: 'Next',
          // color: Theme.of(context).colorScheme.background,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  double getPrice() {
    double price = 0;
    AppData.allProducts.where((e) => e.isliked).forEach((x) {
      price += x.price * x.id;
    });
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _cartItems(),
            Divider(
              thickness: 1,
              height: 70,
            ),
            _price(),
            SizedBox(height: 30),
            _submitButton(context),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
