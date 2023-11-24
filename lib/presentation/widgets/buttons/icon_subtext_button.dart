import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/widgets/extensions/ripple_extension.dart';

class IconSubtextButton extends StatelessWidget {
  const IconSubtextButton({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: color.primaryContainer,
            child: Icon(icon, size: 32)
          )
        ).ripple((){
          onTap?.call();
        }, borderRadius: const BorderRadius.all(Radius.circular(10))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ],
    );
  }
}