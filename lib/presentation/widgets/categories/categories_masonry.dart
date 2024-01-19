import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zona0_apk/domain/entities/category.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class CategoriesMasonry extends StatelessWidget {

  final List<Category> categories;

  const CategoriesMasonry({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          if(index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                _CategoryItem(category: categories[index]),
              ],
            );
          }
          return _CategoryItem(category: categories[index]);
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  const _CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0 ),
      child: CategoryCard(category: category),
    );
  }
}