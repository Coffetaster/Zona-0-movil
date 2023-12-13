import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/widgets/shared/view_image_page.dart';
//* para trabajar con porciento de pantalla
// FractionallySizedBox
class ShowImage {
  static void show(
      {required BuildContext context,
      required String foto,
      File? file,
      required String tag,
      bool isAssets = false}) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            ViewImagePage(url: foto, file: file, tag: tag, isAssets: isAssets)));
  }
}
