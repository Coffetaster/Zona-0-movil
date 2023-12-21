import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.onTap, this.padding, this.elevation = 1, this.color});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double elevation;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget realChild = child;
    if(padding != null) {
      realChild = Padding(
            padding: padding!,
            child: child,
          );
    }
    return Card(
        color: color,
        // surfaceTintColor: Colors.white,
        shadowColor: colorScheme.primary.withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))),
        elevation: elevation,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          // splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: realChild,
        ));
  }
}
