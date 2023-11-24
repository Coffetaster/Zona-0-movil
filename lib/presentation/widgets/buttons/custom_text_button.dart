import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, this.icon, required this.label, this.onPressed});

  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    return icon != null
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
  }
}