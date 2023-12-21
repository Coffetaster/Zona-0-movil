import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ChangePasswordPage extends ConsumerWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changePasswordFormStatus = ref.watch(changePasswordFormProvider);

    void onSubmit() async {
      final code =
          await ref.read(changePasswordFormProvider.notifier).onSubmit();

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
        Future.delayed(Duration.zero, () {
          SnackBarGI.showWithIcon(context,
              icon: Icons.sync_outlined,
              text: AppLocalizations.of(context)!.passwordChangeSuccefully);
          context.pop();
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cambiarContrasena),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      // CustomTextFormField(
                      //   enabled: changePasswordFormStatus.formStatus !=
                      //       FormStatus.validating,
                      //   keyboardType: TextInputType.visiblePassword,
                      //   obscureText:
                      //       changePasswordFormStatus.isObscureOldPassword,
                      //   hint: "* * * * * *",
                      //   suffix: CustomIconButton(
                      //       onPressed: ref
                      //           .read(changePasswordFormProvider.notifier)
                      //           .toggleObscureOldPassword,
                      //       icon: changePasswordFormStatus.isObscureOldPassword
                      //           ? Icons.visibility_off_outlined
                      //           : Icons.visibility_outlined),
                      //   label: AppLocalizations.of(context)!.oldPassword,
                      //   initialValue:
                      //       changePasswordFormStatus.oldPassword.value,
                      //   onFieldSubmitted: (_) {
                      //     if (changePasswordFormStatus.formStatus !=
                      //         FormStatus.validating) {
                      //       onSubmit();
                      //     }
                      //   },
                      //   onChanged: ref
                      //       .read(changePasswordFormProvider.notifier)
                      //       .oldPasswordChanged,
                      //   errorMessage: changePasswordFormStatus.isFormDirty
                      //       ? changePasswordFormStatus.oldPassword
                      //           .errorMessage(context)
                      //       : null,
                      // ),
                      // const Divider(indent: 16, endIndent: 16),
                      CustomTextFormField(
                        enabled: changePasswordFormStatus.formStatus !=
                            FormStatus.validating,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText:
                            changePasswordFormStatus.isObscureNewPassword,
                        hint: "* * * * * *",
                        suffix: CustomIconButton(
                            onPressed: ref
                                .read(changePasswordFormProvider.notifier)
                                .toggleObscureNewPassword,
                            icon: changePasswordFormStatus.isObscureNewPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                        label: AppLocalizations.of(context)!.newPassword,
                        initialValue:
                            changePasswordFormStatus.newPassword.value,
                        onFieldSubmitted: (_) {
                          if (changePasswordFormStatus.formStatus !=
                              FormStatus.validating) {
                            onSubmit();
                          }
                        },
                        onChanged: ref
                            .read(changePasswordFormProvider.notifier)
                            .newPasswordChanged,
                        errorMessage: changePasswordFormStatus.isFormDirty
                            ? changePasswordFormStatus.newPassword
                                .errorMessage(context)
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: LinearProgressIndicator(
                          value: changePasswordFormStatus.percentSecurePassword,
                          minHeight: 20,
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppTheme.borderRadius)),
                          semanticsLabel:
                              AppLocalizations.of(context)!.passwordSecure,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.passwordSecure +
                          " (${changePasswordFormStatus.percentSecurePassword * 100}%)"),
                      if (changePasswordFormStatus.isFormDirty &&
                          changePasswordFormStatus.newPassword
                                  .errorMessage(context) !=
                              null &&
                          changePasswordFormStatus.newPassword
                              .errorMessage(context)!
                              .isNotEmpty)
                        FadeIn(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Radio<int>(
                                      value: changePasswordFormStatus
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
                                      value: changePasswordFormStatus
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
                                      value: changePasswordFormStatus
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
                                      value: changePasswordFormStatus
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
                        )
                    ],
                  )),
              const SizedBox(height: 16),
              changePasswordFormStatus.formStatus != FormStatus.validating
                  ? CustomFilledButton(
                    label: AppLocalizations.of(context)!.cambiar,
                    onPressed: () {
                      onSubmit();
                    },
                  )
                  : ZoomIn(child: const LoadingLogo()),
              const SizedBox(height: 100)
            ],
          ),
        )),
      ),
    );
  }
}
