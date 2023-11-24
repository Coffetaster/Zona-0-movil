import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/data.dart';
import 'package:zona0_apk/presentation/widgets/categories/category_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = AppData.categoryList;
    int index = 0;
    return SingleChildScrollView(
      child: FadeInUp(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Categorías", style: Theme.of(context).textTheme.titleLarge),
              const Divider(
                thickness: 1,
                height: 30,
              ),
              ...categories.map((e) => CategoryCard(category: e, reverseColor: (index++)%2==0)),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}