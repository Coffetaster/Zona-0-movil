import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/category.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/custom_gradient_card.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, this.reverseColor = false});

  final Category category;
  final bool reverseColor;

  @override
  Widget build(BuildContext context) {
    return CustomGradientCard(
      color: category.color,
      reverseColor: reverseColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(category.name, style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white70
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                width: 10,
              ),
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(category.image),
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                        ),
                      )),
                  CustomFilledButton(
                      label: "Ver productos",
                      filledButtonType: FilledButtonType.tonal,
                      onPressed: () {}),
                      SizedBox(
                width: 10,
              ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
