import 'package:flutter/material.dart';

enum IconButtonType { normal, filled, filledTonal, outlined }

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.iconButtonType = IconButtonType.normal,
      this.badgeInfo,
      this.badgeAlignment});

  final IconData icon;
  final String? badgeInfo;
  final AlignmentGeometry? badgeAlignment;
  final VoidCallback? onPressed;
  final IconButtonType iconButtonType;

  @override
  Widget build(BuildContext context) {
    return badgeInfo == null || badgeInfo!.isEmpty
        ? getIconButton()
        : Badge(
            child: getIconButton(),
            label: Text(badgeInfo!),
            alignment: badgeAlignment ?? Alignment(.25,-.35));
  }

  Widget getIconButton() {
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
