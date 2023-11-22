import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/presentation/widgets/extensions/ripple_extension.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.color, this.onPressed});

  final IconData icon;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).colorScheme.background),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}