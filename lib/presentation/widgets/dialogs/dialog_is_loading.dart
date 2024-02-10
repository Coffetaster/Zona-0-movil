import 'package:flutter/material.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DialogIsLoading extends StatelessWidget {
  const DialogIsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: context.width * .5,
      height: context.width * .5,
      child: const Center(child: LoadingLogo()),
    );
  }
}
