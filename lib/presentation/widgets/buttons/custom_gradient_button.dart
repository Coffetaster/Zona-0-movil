// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomGradientButton extends StatelessWidget {
  CustomGradientButton(
      {super.key, required this.label, this.onPressed, this.color});

  final String label;
  final VoidCallback? onPressed;
  Color? color;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    color ??= Theme.of(context).colorScheme.primary;
    return InkWell(
      onTap: onPressed,
      child: Container(
        // width: width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [color!.withOpacity(0.5), color!])),
        child: Text(label.toUpperCase(),
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
