import 'package:flutter/material.dart';

enum IconButtonType { normal, filled, filledTonal, outlined }

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.iconButtonType = IconButtonType.normal});

  final IconData icon;
  final VoidCallback? onPressed;
  final IconButtonType iconButtonType;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = IconButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    switch (iconButtonType) {
      case IconButtonType.normal:
        return IconButton(
            style: buttonStyle, onPressed: onPressed, icon: Icon(icon));
      case IconButtonType.filled:
        return IconButton.filled(
            style: buttonStyle, onPressed: onPressed, icon: Icon(icon));
      case IconButtonType.filledTonal:
        return IconButton.filledTonal(
            style: buttonStyle, onPressed: onPressed, icon: Icon(icon));
      case IconButtonType.outlined:
        return IconButton.outlined(
            style: buttonStyle, onPressed: onPressed, icon: Icon(icon));
    }
  }
}
