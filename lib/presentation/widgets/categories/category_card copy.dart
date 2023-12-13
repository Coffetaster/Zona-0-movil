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
    final part1 =
        Text(category.name, style: Theme.of(context).textTheme.titleLarge!
            // .copyWith(color: Colors.white70)
            );

    final part2 = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(
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
            label: AppLocalizations.of(context)!.verMas,
            filledButtonType: FilledButtonType.tonal,
            onPressed: () {}),
        const SizedBox(
          width: 10,
        ),
      ],
    );

    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 10),
            part1,
            Container(margin: const EdgeInsets.only(right: 12), child: part2)
          ],
        ),
      ),
    );
  }
}
