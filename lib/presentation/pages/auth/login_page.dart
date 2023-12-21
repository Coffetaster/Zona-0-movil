import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/backgrounds/bezier_background.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;

    //* accountFormLoginProvider
    final accountFormLoginStatus = ref.watch(accountFormLoginProvider);

    void onSubmit() async {
      final code = await ref.read(accountFormLoginProvider.notifier).onSubmit();
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
            if (code.toLowerCase().contains("E-mail no verificado".toLowerCase())) {
              context.go(RouterPath.AUTH_VERIFY_CODE_PAGE);
            }
        }
      } else {
        context.go(RouterPath.HOME_PAGE);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        if (accountFormLoginStatus.formStatus == FormStatus.invalid) {
          context.go(RouterPath.HOME_PAGE);
        }
      },
      child: BezierBackground(
        btnBack: accountFormLoginStatus.formStatus != FormStatus.validating,
        onPressed: () => context.go(RouterPath.HOME_PAGE),
        child: FadeInUp(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * .2),
                  _title(context),
                  const SizedBox(height: 50),
                  CustomTextFormField(
                    enabled: accountFormLoginStatus.formStatus !=
                        FormStatus.validating,
                    keyboardType: TextInputType.text,
                    hint: AppLocalizations.of(context)!.correoEjemplo,
                    label: AppLocalizations.of(context)!.usuarioCorreo,
                    initialValue: accountFormLoginStatus.usernameXemail.value,
                    onFieldSubmitted: (_) {
                      if (accountFormLoginStatus.formStatus !=
                          FormStatus.validating) {
                        onSubmit();
                      }
                    },
                    onChanged: ref
                        .read(accountFormLoginProvider.notifier)
                        .usernameXemailChanged,
                    errorMessage: accountFormLoginStatus.isFormDirty
                        ? accountFormLoginStatus.usernameXemail
                            .errorMessage(context)
                        : null,
                  ),
                  CustomTextFormField(
                    enabled: accountFormLoginStatus.formStatus !=
                        FormStatus.validating,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: accountFormLoginStatus.isObscurePassword,
                    hint: "* * * * * *",
                    suffix: CustomIconButton(
                        onPressed: ref
                            .read(accountFormLoginProvider.notifier)
                            .toggleObscurePassword,
                        icon: accountFormLoginStatus.isObscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                    label: AppLocalizations.of(context)!.password,
                    initialValue: accountFormLoginStatus.password.value,
                    onFieldSubmitted: (_) {
                      if (accountFormLoginStatus.formStatus !=
                          FormStatus.validating) {
                        onSubmit();
                      }
                    },
                    onChanged: ref
                        .read(accountFormLoginProvider.notifier)
                        .passwordChanged,
                    errorMessage: accountFormLoginStatus.isFormDirty
                        ? accountFormLoginStatus.password.errorMessage(context)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  accountFormLoginStatus.formStatus != FormStatus.validating
                      ? CustomGradientButton(
                          label: AppLocalizations.of(context)!.autenticar,
                          onPressed: () {
                            onSubmit();
                          })
                      : ZoomIn(
                          child: const SizedBox(
                              width: double.infinity,
                              child: LoadingLogo()),
                        ),
                  if (accountFormLoginStatus.formStatus !=
                      FormStatus.validating)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                          label: AppLocalizations.of(context)!.forgetPassword,
                          onPressed: () {
                            context.push(RouterPath.AUTH_PASSWORD_RESET_PAGE);
                          }),
                    ),
                  SizedBox(height: size.height * .055),
                  if (accountFormLoginStatus.formStatus !=
                      FormStatus.validating)
                    _createAccountLabel(context, color.primary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImagesPath.logo.path,
            height: 50, width: 50, fit: BoxFit.fill),
        Text(
          AppLocalizations.of(context)!.nameApp.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
    // return RichText(
    //   textAlign: TextAlign.center,
    //   text: TextSpan(
    //       text: 'Z',
    //       style: TextStyle(
    //           fontSize: 30,
    //           fontWeight: FontWeight.w700,
    //           color: Color(0xffe46b10)
    //       ),
    //       children: [
    //         TextSpan(
    //           text: 'on',
    //           style: TextStyle(color: Colors.black, fontSize: 30),
    //         ),
    //         TextSpan(
    //           text: 'a 0',
    //           style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
    //         ),
    //       ]),
    // );
  }

  Widget _createAccountLabel(BuildContext context, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.noTienesCuenta,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          CustomTextButton(
              label: AppLocalizations.of(context)!.registrar,
              onPressed: () {
                context.push(RouterPath.AUTH_REGISTER_PAGE);
              })
        ],
      ),
    );
  }
}
