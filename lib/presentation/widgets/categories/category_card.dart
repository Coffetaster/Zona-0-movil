import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/category.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
              Text(category.name, style: Theme.of(context).textTheme.titleLarge),
          CustomFilledButton(
              label: AppLocalizations.of(context)!.verMas,
              filledButtonType: FilledButtonType.tonal,
              onPressed: () {}),
        ],
            ),
      ),
    );
  }
}
