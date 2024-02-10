import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/institutions/donate_osp_form_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DialogDonateInstitucion extends ConsumerWidget {
  const DialogDonateInstitucion({super.key, required this.institutionId});

  final String institutionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSubmit() async {
      final code = await ref.read(donateOSPFormProvider.notifier).onSubmit(institutionId);

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
      }
      else {
        SnackBarGI.showWithIcon(context,
                icon: Icons.check,
                text: AppLocalizations.of(context)!.donacionEnviada);
        context.pop();
      }
    }

    final donateOSPFormState = ref.watch(donateOSPFormProvider);

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.donar,
            style: context.titleLarge,
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            keyboardType: TextInputType.number,
            suffix: Text(AppLocalizations.of(context)!.osp),
            label: AppLocalizations.of(context)!.montoADonar,
            enabled: donateOSPFormState.formStatus == FormStatus.invalid,
            onFieldSubmitted: (_) {
              if (donateOSPFormState.formStatus != FormStatus.validating) {
                onSubmit();
              }
            },
            onChanged: ref.read(donateOSPFormProvider.notifier).amountChanged,
            errorMessage: donateOSPFormState.isFormDirty
                ? donateOSPFormState.amount.errorMessage(context)
                : null,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomTextButton(
                  onPressed: () {
                    context.pop();
                  },
                  label: AppLocalizations.of(context)!.cancelar),
              CustomFilledButton(
                  onPressed: () {
                    onSubmit();
                  },
                  label: AppLocalizations.of(context)!.aceptar),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
