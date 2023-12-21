import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/widgets/shared/view_image_page.dart';

//* para trabajar con porciento de pantalla
// FractionallySizedBox
class ShowImage {
  static void show(
      {required BuildContext context,
      required String imagePath,
      required String heroTag,
      required ExtendedImageType extendedImageType}) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => ViewImagePage(
            imagePath: imagePath,
            heroTag: heroTag,
            extendedImageType: extendedImageType)));
  }

  static void fromNetwork(
      {required BuildContext context,
      required String imagePath,
      required String heroTag}) {
    show(
        context: context,
        imagePath: imagePath,
        heroTag: heroTag,
        extendedImageType: ExtendedImageType.Network);
  }

  static void fromAsset(
      {required BuildContext context,
      required String imagePath,
      required String heroTag}) {
    show(
        context: context,
        imagePath: imagePath,
        heroTag: heroTag,
        extendedImageType: ExtendedImageType.Asset);
  }

  static void fromFile(
      {required BuildContext context,
      required String imagePath,
      required String heroTag}) {
    show(
        context: context,
        imagePath: imagePath,
        heroTag: heroTag,
        extendedImageType: ExtendedImageType.File);
  }
}
