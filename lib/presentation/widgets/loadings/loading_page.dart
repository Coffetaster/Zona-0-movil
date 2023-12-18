import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';
import 'package:zona0_apk/main.dart';

import 'loading_logo.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const LoadingLogo(),
        Text(
            message == null ? AppLocalizations.of(context)!.cargando : message!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        Lottie.asset(LottiesPath.loading_3.path,
            height: 50, width: 100, fit: BoxFit.fill),
      ],
    );
  }
}
