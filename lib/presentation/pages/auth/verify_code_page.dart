import 'package:animate_do/animate_do.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class VerifyCodePage extends ConsumerWidget {
  const VerifyCodePage({super.key});

  final String idConfirmExitProvider = "VerifyCodePage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;

    final countdownTimerIsRunning =
        ref.watch(countdownTimerProvider(idConfirmExitProvider));
    final confirmExit = ref.watch(confirmExitProvider(idConfirmExitProvider));
    if (confirmExit == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        context.pop();
        context.go(RouterPath.AUTH_LOGIN_PAGE);
      });
    }
    return BezierBackground(
      btnBack: true,
      onPressed: () =>
          Utils.showDialogConfirmSalir(context, ref, idConfirmExitProvider),
      child: FadeInUp(
        child: PopScope(
          canPop: confirmExit != 0,
          onPopInvoked: (canPop) {
            Utils.showDialogConfirmSalir(context, ref, idConfirmExitProvider);
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
                          Text(AppLocalizations.of(context)!.entreCodigo,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.verifyCodeContent,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 10,
                            label: AppLocalizations.of(context)!.codigo,
                          ),
                          const SizedBox(height: 8),
                          CustomFilledButton(
                              label: "Verificar", onPressed: () {}),
                          const SizedBox(height: 8),
                          const Divider(indent: 10, endIndent: 10),
                          CustomTextButton(
                              label:
                                  AppLocalizations.of(context)!.reenviarCodigo,
                              icon: Icons.refresh_outlined,
                              onPressed: countdownTimerIsRunning
                                  ? null
                                  : () {
                                      ref
                                          .read(countdownTimerProvider(
                                                  idConfirmExitProvider)
                                              .notifier)
                                          .setState = true;
                                    }),
                          CountdownTimer(
                            onEnd: (){
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
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              if (time == null) {
                                return const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.timer_outlined),
                                    Text("--:--")
                                  ],
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
