import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/backgrounds/bezier_background.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class RegisterClientPage extends ConsumerWidget {
  const RegisterClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final confirmExit = ref.watch(confirmExitProvider);
    if (confirmExit) {
      Future.delayed(Duration(milliseconds: 0), () {
        context.pop();
        context.pop();
      });
    }
    return BezierBackground(
      btnBack: true,
      onPressed: () => showDialogConfirmSalir(context, ref),
      child: FadeInUp(
        child: PopScope(
          canPop: confirmExit,
          onPopInvoked: (canPop) {
            showDialogConfirmSalir(context, ref);
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
                  StepsWidgetGI(
                    textFinish: AppLocalizations.of(context)!.registrar,
                    onTapFinish: () {
                      SnackbarGI.show(context, text: "En desarrollo");
                    },
                    children: [
                      widgetStep1(context),
                      widgetStep2(context),
                    ],
                  ),
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
      AppLocalizations.of(context)!.registro,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
    );
  }

  Widget widgetStep1(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.datosPersonales,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            CustomTextFormField(
              keyboardType: TextInputType.name,
              label: AppLocalizations.of(context)!.nombre,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.name,
              label: AppLocalizations.of(context)!.apellidos,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.phone,
              maxLength: 8,
              prefix: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("(+53)",
                    style: TextStyle(color: Colors.grey.shade500)),
              ),
              label: AppLocalizations.of(context)!.telefono,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              maxLength: 11,
              label: AppLocalizations.of(context)!.ci,
            ),
          ],
        ));
  }

  Widget widgetStep2(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.datosUsuario,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            CustomTextFormField(
              keyboardType: TextInputType.text,
              label: AppLocalizations.of(context)!.usuario,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              label: AppLocalizations.of(context)!.correo,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hint: "* * * * * *",
              suffix: CustomIconButton(
                onPressed: () {
                  // isObscureText.value = !isObscureText.value;
                },
                icon: Icons.visibility_off_outlined,
                // isObscureText.value
                //     ? const Icon(Icons.visibility_off_outlined)
                //     : const Icon(Icons.visibility_outlined)
              ),
              label: AppLocalizations.of(context)!.password,
            ),
          ],
        ));
  }

  void showDialogConfirmSalir(BuildContext context, WidgetRef ref) {
    DialogGI.showAlertDialog(context,
        title: AppLocalizations.of(context)!.salir, content: AppLocalizations.of(context)!.salirContent, actionOk: () {
      ref.read(confirmExitProvider.notifier).state = true;
    });
  }
}
