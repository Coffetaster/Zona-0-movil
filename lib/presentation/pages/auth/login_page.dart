import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/backgrounds/bezier_background.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/inputs/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return BezierBackground(
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
                  keyboardType: TextInputType.emailAddress,
                  hint: AppLocalizations.of(context)!.correoEjemplo,
                  label: AppLocalizations.of(context)!.usuarioCorreo,
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hint: "* * * * * *",
                  label: AppLocalizations.of(context)!.password,
                ),
                // _emailPasswordWidget(),
                const SizedBox(height: 20),
                CustomGradientButton(
                    label: "Autenticar",
                    onPressed: () => context.go(RouterPath.HOME_PAGE)),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                      label: AppLocalizations.of(context)!.forgetPassword,
                      onPressed: () {}),
                ),
                SizedBox(height: size.height * .055),
                _createAccountLabel(context, color.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      "Zona 0",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
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
          const Text(
            '¿No tienes cuenta?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          CustomTextButton(
              label: "Registrar",
              onPressed: () {
                context.push(RouterPath.REGISTER_PAGE);
              })
        ],
      ),
    );
  }
}
