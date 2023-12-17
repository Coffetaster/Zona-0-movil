import 'package:animate_do/animate_do.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class VerifyCodePage extends ConsumerWidget {
  const VerifyCodePage({super.key});

  final String idConfirmExitProvider = "VerifyCodePage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final accountFormVerifyCodeSate = ref.watch(accountFormVerifyCodeProvider);
    final countdownTimerIsRunning =
        ref.watch(countdownTimerProvider(idConfirmExitProvider));
    final confirmExit = ref.watch(confirmExitProvider(idConfirmExitProvider));
    if (confirmExit == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        context.pop();
        context.go(RouterPath.AUTH_LOGIN_PAGE);
      });
    } else if (confirmExit == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        context.go(RouterPath.AUTH_LOGIN_PAGE);
        SnackBarGI.showWithIcon(context,
            icon: Icons.check,
            text: AppLocalizations.of(context)!.cuentaVerificada);
      });
    }

    void onSubmit() async {
      final code =
          await ref.read(accountFormVerifyCodeProvider.notifier).onSubmit();

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
        ref.read(confirmExitProvider(idConfirmExitProvider).notifier).state = 2;
      }
    }

    return BezierBackground(
      btnBack: accountFormVerifyCodeSate.formStatus == FormStatus.invalid,
      onPressed: () =>
          Utils.showDialogConfirmSalir(context, ref, idConfirmExitProvider),
      child: FadeInUp(
        child: PopScope(
          canPop: confirmExit != 0,
          onPopInvoked: (canPop) {
            if (accountFormVerifyCodeSate.formStatus == FormStatus.invalid && confirmExit == 0) {
              Utils.showDialogConfirmSalir(context, ref, idConfirmExitProvider);
            }
          },
          child: accountFormVerifyCodeSate.formStatus != FormStatus.invalid
              ? ZoomIn(
                  child: SizedBox(
                      width: double.infinity,
                      child: LoadingPage(
                          message: AppLocalizations.of(context)!
                              .enviandoEsperePlis)),
                )
              : Container(
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
                                Text(AppLocalizations.of(context)!.entreCodigo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .verifyCodeContent,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CustomTextFormField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 10,
                                  label: AppLocalizations.of(context)!.codigo,
                                  initialValue:
                                      accountFormVerifyCodeSate.code.value,
                                  onFieldSubmitted: (_) {
                                    if (accountFormVerifyCodeSate.formStatus !=
                                        FormStatus.validating) {
                                      onSubmit();
                                    }
                                  },
                                  onChanged: ref
                                      .read(accountFormVerifyCodeProvider
                                          .notifier)
                                      .codeChanged,
                                  errorMessage:
                                      accountFormVerifyCodeSate.isFormDirty
                                          ? accountFormVerifyCodeSate.code
                                              .errorMessage(context)
                                          : null,
                                ),
                                const SizedBox(height: 8),
                                CustomFilledButton(
                                    label:
                                        AppLocalizations.of(context)!.verificar,
                                    onPressed: onSubmit),
                                const SizedBox(height: 8),
                                const Divider(indent: 10, endIndent: 10),
                                CustomTextButton(
                                    label: AppLocalizations.of(context)!
                                        .reenviarCodigo,
                                    icon: Icons.refresh_outlined,
                                    onPressed: countdownTimerIsRunning
                                        ? null
                                        : () {
                                            Utils.showSnackbarEnDesarrollo(
                                                context);
                                            ref
                                                .read(countdownTimerProvider(
                                                        idConfirmExitProvider)
                                                    .notifier)
                                                .setState = true;
                                          }),
                                CountdownTimer(
                                  onEnd: () {
                                    ref
                                        .read(countdownTimerProvider(
                                                idConfirmExitProvider)
                                            .notifier)
                                        .setState = false;
                                  },
                                  endTime: countdownTimerIsRunning
                                      ? ref
                                          .read(countdownTimerProvider(
                                                  idConfirmExitProvider)
                                              .notifier)
                                          .endTime
                                      : 0,
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.timer_outlined),
                                          Text("--:--")
                                        ],
                                      );
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.timer_outlined),
                                        Text(
                                            "${time.min != null ? time.min!.addLeadingZeros(2) : "00"}:${time.sec!.addLeadingZeros(2)}")
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                              ],
                            )),
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
      AppLocalizations.of(context)!.verifyCode,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
