import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/accounts/accounts.dart';
import 'package:zona0_apk/presentation/providers/redeem_code/redeem_code_form_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class RedeemCodePage extends ConsumerWidget {
  const RedeemCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final redeemCodeFormState = ref.watch(redeemCodeFormProvider);
    void onSubmit() async {
      final code = await ref.read(redeemCodeFormProvider.notifier).onSubmit();

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
        ref.read(accountProvider.notifier).getOSPPoints();
        context.pop();
        SnackBarGI.showWithIcon(context,
            icon: Icons.check,
            text: AppLocalizations.of(context)!.redeemCodeOk);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.canjear_codigo),
        centerTitle: false,
      ),
      body: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(ImagesPath.happy_birthday.path,
                    width: double.infinity, height: context.height * .3),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomCard(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: <Widget>[
                      const SizedBox(height: 8),
                      Text(AppLocalizations.of(context)!.entreCodigo,
                          style: context.titleMedium),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.canjear_codigo_content,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 10,
                        label: AppLocalizations.of(context)!.codigo,
                        initialValue: redeemCodeFormState.code.value,
                        enabled: redeemCodeFormState.formStatus !=
                            FormStatus.validating,
                        onFieldSubmitted: (_) {
                          if (redeemCodeFormState.formStatus !=
                              FormStatus.validating) {
                            onSubmit();
                          }
                        },
                        onChanged: ref
                            .read(redeemCodeFormProvider.notifier)
                            .codeChanged,
                        errorMessage: redeemCodeFormState.isFormDirty
                            ? redeemCodeFormState.code.errorMessage(context)
                            : null,
                      ),
                      const SizedBox(height: 8),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  redeemCodeFormState.formStatus != FormStatus.validating
                      ? CustomFilledButton(
                          label: AppLocalizations.of(context)!.verificar,
                          onPressed: () {
                            onSubmit();
                          },
                        )
                      : const LoadingLogo(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
