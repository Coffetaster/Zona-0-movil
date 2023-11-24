import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
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
        ? ElevatedButton.icon(
            style: buttonStyle,
            label: Text(label.toUpperCase()),
            icon: Icon(icon),
            onPressed: onPressed,
          )
        : ElevatedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(label.toUpperCase()),
          );
  }
}
