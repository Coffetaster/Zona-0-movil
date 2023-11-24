// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomGradientCard extends StatelessWidget {
  CustomGradientCard(
      {super.key,
      required this.child,
      this.onTap,
      this.color,
      this.reverseColor = false});

  final Widget child;
  final bool reverseColor;
  Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).colorScheme.primary;
    final c1 = reverseColor ? color! : color!.withOpacity(0.5);
    final c2 = reverseColor ? color!.withOpacity(0.5) : color!;
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 1,
        child: Material(
            child: InkWell(
          onTap: onTap,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [c1, c2])),
              child: child),
        )));
  }
}
