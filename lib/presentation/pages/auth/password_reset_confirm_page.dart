import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class PasswordResetConfirmPage extends ConsumerWidget {
  const PasswordResetConfirmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final accountFormResetPasswordConfirmStatus =
        ref.watch(accountFormResetPasswordConfirmProvider);

    void onSubmit() async {
      final code = await ref
          .read(accountFormResetPasswordConfirmProvider.notifier)
          .onSubmit();

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
            icon: Icons.check,
            text: AppLocalizations.of(context)!.passwordRestablecidaExito);
        context.go(RouterPath.AUTH_LOGIN_PAGE);
      }
    }

    return BezierBackground(
      btnBack: accountFormResetPasswordConfirmStatus.formStatus !=
          FormStatus.validating,
      onPressed: () {
        context.go(RouterPath.AUTH_LOGIN_PAGE);
      },
      child: FadeInUp(
        child: PopScope(
          canPop: false,
          onPopInvoked: (_) {
            if (accountFormResetPasswordConfirmStatus.formStatus ==
                FormStatus.invalid) context.go(RouterPath.AUTH_LOGIN_PAGE);
          },
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
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 10,
                            label: AppLocalizations.of(context)!.idSolicitud,
                            initialValue:
                                accountFormResetPasswordConfirmStatus.uid.value,
                            enabled: accountFormResetPasswordConfirmStatus
                                    .formStatus !=
                                FormStatus.validating,
                            onFieldSubmitted: (_) {
                              if (accountFormResetPasswordConfirmStatus
                                      .formStatus !=
                                  FormStatus.validating) {
                                onSubmit();
                              }
                            },
                            onChanged: ref
                                .read(accountFormResetPasswordConfirmProvider
                                    .notifier)
                                .uidChanged,
                            errorMessage: accountFormResetPasswordConfirmStatus
                                    .isFormDirty
                                ? accountFormResetPasswordConfirmStatus.uid
                                    .errorMessage(context)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 10,
                            label: AppLocalizations.of(context)!.codigo,
                            initialValue: accountFormResetPasswordConfirmStatus
                                .token.value,
                            enabled: accountFormResetPasswordConfirmStatus
                                    .formStatus !=
                                FormStatus.validating,
                            onFieldSubmitted: (_) {
                              if (accountFormResetPasswordConfirmStatus
                                      .formStatus !=
                                  FormStatus.validating) {
                                onSubmit();
                              }
                            },
                            onChanged: ref
                                .read(accountFormResetPasswordConfirmProvider
                                    .notifier)
                                .tokenChanged,
                            errorMessage: accountFormResetPasswordConfirmStatus
                                    .isFormDirty
                                ? accountFormResetPasswordConfirmStatus.token
                                    .errorMessage(context)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            enabled: accountFormResetPasswordConfirmStatus
                                    .formStatus !=
                                FormStatus.validating,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: accountFormResetPasswordConfirmStatus
                                .isObscureNewPassword,
                            hint: "* * * * * *",
                            suffix: CustomIconButton(
                                onPressed: ref
                                    .read(
                                        accountFormResetPasswordConfirmProvider
                                            .notifier)
                                    .toggleObscureNewPassword,
                                icon: accountFormResetPasswordConfirmStatus
                                        .isObscureNewPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                            label: AppLocalizations.of(context)!.newPassword,
                            initialValue: accountFormResetPasswordConfirmStatus
                                .newPassword.value,
                            onFieldSubmitted: (_) {
                              if (accountFormResetPasswordConfirmStatus
                                      .formStatus !=
                                  FormStatus.validating) {
                                onSubmit();
                              }
                            },
                            onChanged: ref
                                .read(accountFormResetPasswordConfirmProvider
                                    .notifier)
                                .newPasswordChanged,
                            errorMessage: accountFormResetPasswordConfirmStatus
                                    .isFormDirty
                                ? accountFormResetPasswordConfirmStatus
                                    .newPassword
                                    .errorMessage(context)
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: LinearProgressIndicator(
                              value: accountFormResetPasswordConfirmStatus
                                  .percentSecurePassword,
                              minHeight: 20,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppTheme.borderRadius)),
                              semanticsLabel:
                                  AppLocalizations.of(context)!.passwordSecure,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.passwordSecure +
                              " (${accountFormResetPasswordConfirmStatus.percentSecurePassword * 100}%)"),
                          if (accountFormResetPasswordConfirmStatus
                                  .isFormDirty &&
                              accountFormResetPasswordConfirmStatus.newPassword
                                      .errorMessage(context) !=
                                  null &&
                              accountFormResetPasswordConfirmStatus.newPassword
                                  .errorMessage(context)!
                                  .isNotEmpty)
                            FadeIn(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio<int>(
                                          value:
                                              accountFormResetPasswordConfirmStatus
                                                      .passwordRequired1
                                                  ? 0
                                                  : -1,
                                          groupValue: 0,
                                          onChanged: (_) {},
                                          toggleable: false),
                                      Text(AppLocalizations.of(context)!
                                          .passwordSecureReq1)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio<int>(
                                          value:
                                              accountFormResetPasswordConfirmStatus
                                                      .passwordRequired2
                                                  ? 1
                                                  : -1,
                                          groupValue: 1,
                                          onChanged: (_) {},
                                          toggleable: false),
                                      Text(AppLocalizations.of(context)!
                                          .passwordSecureReq2)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio<int>(
                                          value:
                                              accountFormResetPasswordConfirmStatus
                                                      .passwordRequired3
                                                  ? 2
                                                  : -1,
                                          groupValue: 2,
                                          onChanged: (_) {},
                                          toggleable: false),
                                      Text(AppLocalizations.of(context)!
                                          .passwordSecureReq3)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio<int>(
                                          value:
                                              accountFormResetPasswordConfirmStatus
                                                      .passwordRequired4
                                                  ? 3
                                                  : -1,
                                          groupValue: 3,
                                          onChanged: (_) {},
                                          toggleable: false),
                                      Text(AppLocalizations.of(context)!
                                          .passwordSecureReq4)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )),
                  const SizedBox(height: 8),
                  accountFormResetPasswordConfirmStatus.formStatus ==
                          FormStatus.invalid
                      ? CustomFilledButton(
                          label: AppLocalizations.of(context)!.aceptar,
                          onPressed: () {
                            onSubmit();
                          })
                      : ZoomIn(child: const LoadingLogo()),
                  const SizedBox(height: 80),
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
      AppLocalizations.of(context)!.restablecerPassword,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
