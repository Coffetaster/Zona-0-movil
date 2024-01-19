import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';

class TextLoading3DotsWidget extends StatelessWidget {
  const TextLoading3DotsWidget({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null && label!.trim().isNotEmpty)
          Text(
            label!,
            style: context.titleMedium.copyWith(color: context.primary),
          ),
        if (label != null && label!.trim().isNotEmpty) const SizedBox(width: 2),
        ...[0, 1, 2].map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Flash(
              infinite: true,
              duration: const Duration(milliseconds: 3000),
              delay: Duration(milliseconds: 375 * e),
              child: Container(
                decoration: BoxDecoration(
                    color: context.primary,
                    borderRadius: BorderRadius.circular(100)),
                width: 8,
                height: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
