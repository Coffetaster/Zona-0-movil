// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomGradientCard extends StatelessWidget {
  CustomGradientCard(
      {super.key,
      required this.child,
      this.onTap,
      this.color,
      this.reverseColor = false,
      this.padding});

  final Widget child;
  final bool reverseColor;
  Color? color;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).colorScheme.primary;
    final c1 = reverseColor ? color! : color!.withOpacity(0.5);
    final c2 = reverseColor ? color!.withOpacity(0.5) : color!;
    Widget realChild = child;
    if(padding != null) {
      realChild = Padding(
            padding: padding!,
            child: child,
          );
    }
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))),
        elevation: 1,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          // splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [c1, c2])),
              child: realChild),
        ));
  }
}
