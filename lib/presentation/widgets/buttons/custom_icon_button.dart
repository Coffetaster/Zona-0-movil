import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

enum IconButtonType { normal, filled, filledTonal, outlined }

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.iconButtonType = IconButtonType.normal,
      this.badgeInfo,
      this.badgeAlignment,
      this.color,
      this.radius = AppTheme.borderRadius,
      this.backgroundColor,
      this.size});

  final IconData icon;
  final String? badgeInfo;
  final AlignmentGeometry? badgeAlignment;
  final VoidCallback? onPressed;
  final IconButtonType iconButtonType;
  final double radius;
  final Color? color;
  final Color? backgroundColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return badgeInfo == null || badgeInfo!.isEmpty
        ? getIconButton()
        : Badge(
            backgroundColor: colorScheme.tertiary,
            label: Text(badgeInfo!,
                style: TextStyle(color: colorScheme.onTertiary)),
            alignment: badgeAlignment ?? const Alignment(.25, -.35),
            child: getIconButton());
  }

  Widget getIconButton() {
    ButtonStyle buttonStyle = IconButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))));
    switch (iconButtonType) {
      case IconButtonType.normal:
        return IconButton(
            style: buttonStyle,
            onPressed: onPressed,
            icon: Icon(icon, color: color, size: size));
      case IconButtonType.filled:
        return IconButton.filled(
            style: buttonStyle,
            onPressed: onPressed,
            icon: Icon(icon, color: color, size: size));
      case IconButtonType.filledTonal:
        return IconButton.filledTonal(
            style: buttonStyle,
            onPressed: onPressed,
            icon: Icon(icon, color: color, size: size));
      case IconButtonType.outlined:
        return IconButton.outlined(
            style: buttonStyle,
            onPressed: onPressed,
            icon: Icon(icon, color: color, size: size));
    }
  }
}
