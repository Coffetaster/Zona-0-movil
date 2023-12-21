import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class PasswordResetPage extends ConsumerWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final accountFormResetPasswordStatus =
        ref.watch(accountFormResetPasswordProvider);

    void onSubmit() async {
      final code =
          await ref.read(accountFormResetPasswordProvider.notifier).onSubmit();

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
        SnackBarGI.showWithIcon(context,
            icon: Icons.email_outlined,
            text: AppLocalizations.of(context)!.reviseCorreo);
        context.go(RouterPath.AUTH_PASSWORD_RESET_CONFIRM_PAGE);
      }
    }

    return BezierBackground(
      btnBack: accountFormResetPasswordStatus.formStatus == FormStatus.invalid,
      child: FadeInUp(
        child: PopScope(
          canPop:
              accountFormResetPasswordStatus.formStatus == FormStatus.invalid,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * .2),
                  _title(context),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomCard(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .forgetPasswordContent,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            label: AppLocalizations.of(context)!.correo,
                            hint: AppLocalizations.of(context)!.correoEjemplo,
                            enabled:
                                accountFormResetPasswordStatus.formStatus ==
                                    FormStatus.invalid,
                            initialValue:
                                accountFormResetPasswordStatus.email.value,
                            onFieldSubmitted: (_) {
                              if (accountFormResetPasswordStatus.formStatus !=
                                  FormStatus.validating) {
                                onSubmit();
                              }
                            },
                            onChanged: ref
                                .read(accountFormResetPasswordProvider.notifier)
                                .emailChanged,
                            errorMessage:
                                accountFormResetPasswordStatus.isFormDirty
                                    ? accountFormResetPasswordStatus.email
                                        .errorMessage(context)
                                    : null,
                          ),
                        ],
                      )),
                  const SizedBox(height: 8),
                  accountFormResetPasswordStatus.formStatus ==
                          FormStatus.invalid
                      ? CustomFilledButton(
                          label: AppLocalizations.of(context)!.aceptar,
                          onPressed: () {
                            onSubmit();
                          })
                      : ZoomIn(child: const LoadingLogo()),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.recuperarPassword,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
