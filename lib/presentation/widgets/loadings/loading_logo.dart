import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/constants/lotties_path.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(LottiesPath.loading_1.path,
              height: 200, width: 200, fit: BoxFit.fill),
          Image.asset(ImagesPath.logo.path,
              height: 50, width: 50, fit: BoxFit.fill)
        ],
      ),
    );
  }
}
