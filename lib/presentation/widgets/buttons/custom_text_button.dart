import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      this.icon,
      required this.label,
      this.onPressed,
      this.imageAsset,
      this.radius = AppTheme.borderRadius,
      this.width,
      this.height,
      this.backgroundColor,
      this.centerContent = true});

  final IconData? icon;
  final String? imageAsset;
  final String label;
  final VoidCallback? onPressed;
  final double radius;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        alignment: centerContent ? null : const Alignment(-1, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))));
    final button = icon != null
        ? TextButton.icon(
            style: buttonStyle,
            label: Text(label.toUpperCase()),
            icon: Icon(icon),
            onPressed: onPressed,
          )
        : TextButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(label.toUpperCase()),
          );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}
