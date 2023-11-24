import 'dart:ui';

class Category {
  int id;
  String name;
  String image;
  bool isSelected;
  Color? color;
  Category({
      required this.id,
      required this.name,
      this.isSelected = false,
      required this.image,
      this.color,
    });
}
