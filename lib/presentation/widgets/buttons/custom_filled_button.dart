import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

enum FilledButtonType {
  normal,
  tonal,
}

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.icon,
    this.imageAsset,
    required this.label,
    this.onPressed,
    this.filledButtonType = FilledButtonType.normal,
    this.width,
    this.height,
    this.backgroundColor,
    this.centerContent = true,
    this.radius = AppTheme.borderRadius,
  });

  final IconData? icon;
  final String? imageAsset;
  final String label;
  final VoidCallback? onPressed;
  final FilledButtonType filledButtonType;
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

    late Widget button;
    if (filledButtonType == FilledButtonType.normal) {
      button = (icon != null || imageAsset != null)
          ? FilledButton.icon(
              style: buttonStyle,
              label: Text(label.toUpperCase()),
              icon: imageAsset != null
                  ? Image.asset(imageAsset!, width: 25, height: 25)
                  : Icon(icon),
              onPressed: onPressed,
            )
          : FilledButton(
              style: buttonStyle,
              onPressed: onPressed,
              child: Text(label.toUpperCase()),
            );
    } else {
      button = (icon != null || imageAsset != null)
          ? FilledButton.tonalIcon(
              style: buttonStyle,
              label: Text(label.toUpperCase()),
              icon: imageAsset != null
                  ? Image.asset(imageAsset!, width: 25, height: 25)
                  : Icon(icon),
              onPressed: onPressed,
            )
          : FilledButton.tonal(
              style: buttonStyle,
              onPressed: onPressed,
              child: Text(label.toUpperCase()),
            );
    }

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}
