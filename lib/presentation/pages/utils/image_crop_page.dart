import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/loadings/loadings.dart';

/*
  MODO DE USO:
    - Instalar las librerías: image_picker, custom_image_crop, path_provider

    - Copiar este archivo en tu proyecto y corregir errores que puedan existir

    - Configurar las rutas
    GoRoute(
      path: RouterPath.UTILS_IMAGE_CROP_PAGE,
      pageBuilder: (context, state) {
        final originalPath = state.extra as String?;
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: ImageCropPage(originalPath: originalPath));
      },
    ),

    - Para usarlo utilizar la siguiente función
    Future<String?> selectAndCropImage(BuildContext context) async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        String? imagePath = await context.push(RouterPath.UTILS_IMAGE_CROP_PAGE, extra: image.path);
        return imagePath;
      }
      return null;
    }

    Nota: Para más opciones de la librería de recorte visitar su enlace:
    https://pub.dev/packages/custom_image_crop
*/

class ImageCropPage extends HookWidget {
  ImageCropPage({super.key, required this.originalPath});
  final String? originalPath;

  final CustomImageCropController controller = CustomImageCropController();

  @override
  Widget build(BuildContext context) {
    if (originalPath == null) {
      Future.delayed(Duration.zero, () {
        exit(context);
      });
      return Container();
    }

    final isCropping = useState<bool>(false);

    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        if (!isCropping.value) {
          exit(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: HeroTags.registerUserFormTag,
              child: CustomImageCrop(
                cropController: controller,
                image: FileImage(File(originalPath!)),
                canRotate: false,
                canMove: !isCropping.value,
                canScale: !isCropping.value,
                forceInsideCropArea: true,
                imageFit: CustomImageFit.fitVisibleSpace,
                customProgressIndicator: const LoadingLogo(),
                cropPercentage: .6,
                clipShapeOnCrop: false,
              ),
            ),
            isCropping.value == true
                ? Center(child: ZoomIn(child: LoadingLogo()))
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomFilledButton(
                                label: AppLocalizations.of(context)!.cancelar,
                                onPressed: isCropping.value == true
                                    ? null
                                    : () {
                                        exit(context);
                                      }),
                            CustomIconButton(
                                icon: Icons.rotate_right,
                                iconButtonType: IconButtonType.filled,
                                onPressed: isCropping.value == true
                                    ? null
                                    : () => controller.addTransition(
                                        CropImageData(angle: pi / 2))),
                            CustomFilledButton(
                                label: AppLocalizations.of(context)!.recortar,
                                onPressed: isCropping.value == true
                                    ? null
                                    : () async {
                                        isCropping.value = true;
                                        final image =
                                            await controller.onCropImage();
                                        if (image != null) {
                                          final tempDir =
                                              await getTemporaryDirectory();
                                          final name =
                                              "image-${DateTime.now().millisecondsSinceEpoch}.jpg";
                                          final path = '${tempDir.path}/$name';
                                          final file =
                                              await new File(path).create();
                                          file.writeAsBytesSync(image.bytes);
                                          exit(context, path);
                                        } else {
                                          isCropping.value = false;
                                          //* Ha ocurrido un error
                                        }
                                      }),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void exit(BuildContext context, [String? result]) {
    controller.dispose();
    context.pop(result);
  }
}
