import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/category.dart';
import 'package:zona0_apk/presentation/widgets/extensions/ripple_extension.dart';

class CategoryChip extends StatelessWidget {
  // final String imagePath;
  // final String text;
  final ValueChanged<Category> onSelected;
  final Category? model;
  const CategoryChip({Key? key, this.model, required this.onSelected}) : super(key: key);

  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return model == null
        ? Container(width: 5)
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Container(
              padding: AppTheme.hPadding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: model!.isSelected
                    ? color.background
                    : Colors.transparent,
                border: Border.all(
                  color: model!.isSelected ? color.primary : Colors.grey.shade300,
                  width: model!.isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(model!.image),
                  Text(
                    model!.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ).ripple(
              () {
                onSelected(model!);
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          );
  }
}
