import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';
import 'package:zona0_apk/main.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(LottiesPath.loading_1.path, height: 200, width: 200, fit: BoxFit.fill),
              Image.asset(ImagesPath.logo.path, height: 50, width: 50, fit: BoxFit.fill)
            ],
          ),
        ),
        Text(AppLocalizations.of(context)!.cargando, style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary
        )),
        Lottie.asset(LottiesPath.loading_3.path, height: 50, width: 100, fit: BoxFit.fill),
      ],
    );
  }
}