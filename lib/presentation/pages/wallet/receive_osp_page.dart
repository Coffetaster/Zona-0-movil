import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/transfer/transfer.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ReceiveOSPPage extends ConsumerWidget {
  const ReceiveOSPPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiveOSPFormState = ref.watch(receiveOSPFormProvider);

    void onSubmit() async {
      final code = await ref.read(receiveOSPFormProvider.notifier).onSubmit();

      if (code != "200") {
        switch (code) {
          case "412":
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.camposConError);
            break;
          case "498":
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.compruebeConexion);
            break;
          default:
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: code.isEmpty
                    ? AppLocalizations.of(context)!.haOcurridoError
                    : code);
        }
      } else {
        context.pop();
        SnackBarGI.showWithIcon(context,
            icon: Icons.check_outlined,
            text: AppLocalizations.of(context)!.reciboCreado);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.recibirOSP),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              CustomCard(
                padding: const EdgeInsets.all(8),
                child: Column(children: <Widget>[
                  const SizedBox(height: 8),
                  Text(AppLocalizations.of(context)!.entreMonto,
                      style: context.titleMedium),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.recibirOSP_content,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    suffix: Text(AppLocalizations.of(context)!.osp),
                    label: AppLocalizations.of(context)!.montoRecibir,
                    enabled:
                        receiveOSPFormState.formStatus == FormStatus.invalid,
                    onFieldSubmitted: (_) {
                      if (receiveOSPFormState.formStatus !=
                          FormStatus.validating) {
                        onSubmit();
                      }
                    },
                    onChanged:
                        ref.read(receiveOSPFormProvider.notifier).amountChanged,
                    errorMessage: receiveOSPFormState.isFormDirty
                        ? receiveOSPFormState.amount.errorMessage(context)
                        : null,
                  ),
                  const SizedBox(height: 8),
                ]),
              ),
              const SizedBox(height: 16),
              receiveOSPFormState.formStatus == FormStatus.invalid
                  ? CustomFilledButton(
                      label: AppLocalizations.of(context)!.generarCodigo,
                      onPressed: () {
                        onSubmit();
                      },
                    )
                  : const LoadingLogo(),
            ]),
          ),
        ),
      ),
    );
  }
}
