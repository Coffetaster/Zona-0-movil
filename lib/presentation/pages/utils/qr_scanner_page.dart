import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';

/*
  MODO DE USO:
  - Instalar las librerías: mobile_scanner, qr_scanner_overlay

  - Copiar este archivo en tu proyecto y corregir errores que puedan existir

  - Configurar las rutas
    GoRoute(
      path: RouterPath.UTILS_QR_SCANNER_PAGE,
      pageBuilder: (context, state) {
        return RouterTransition.fadeTransitionPage(
            key: state.pageKey, child: QrScannerPage());
      },
    ),

  - Usarlo de la siguiente manera
  String? result = await context.push(RouterPath.UTILS_QR_SCANNER_PAGE);
  if(result != null){
    SnackBarGI.showCustom(context, text: result);
  }
*/

// ignore: must_be_immutable
class QrScannerPage extends StatelessWidget {
  QrScannerPage({super.key});

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    bool detectOk = false;
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isEmpty || detectOk) return;
              detectOk = true;
              context.pop(barcodes[0].rawValue);
            },
          ),
          QRScannerOverlay(
            borderColor: context.primary,
          ),
          Positioned(
              top: 0,
              right: 0,
              child: FadeInDown(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ValueListenableBuilder<TorchState>(
                        valueListenable: cameraController.torchState,
                        builder: (context, state, child) {
                          return CustomIconButton(
                              icon: state == TorchState.off
                                  ? Icons.flash_off
                                  : Icons.flash_on,
                              color: context.primary,
                              onPressed: () => cameraController.toggleTorch());
                        },
                      ),
                      ValueListenableBuilder<TorchState>(
                        valueListenable: cameraController.torchState,
                        builder: (context, state, child) {
                          return CustomIconButton(
                              icon: state == TorchState.off
                                  ? Icons.camera_front
                                  : Icons.camera_rear,
                              color: context.primary,
                              onPressed: () => cameraController.switchCamera());
                        },
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeInUp(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFilledButton(
                          label: AppLocalizations.of(context)!.cancelar,
                          onPressed: () => context.pop()),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
