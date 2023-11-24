import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/curves/bezierContainer.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(color: color.primary),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * .2),
                    _title(context),
                    SizedBox(
                      height: 50,
                    ),
                    const CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    hint: "johndoe",
                    label: "Usuario",
                  ),
                    const CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    hint: "johndoe@dominio.com",
                    label: "Correo",
                  ),
                  const CustomTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    hint: "* * * * * *",
                    label: "Contraseña",
                  ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomGradientButton(
                      label: "Registrar",
                      onPressed: () => context.go(RouterPath.HOME_PAGE)),
                    SizedBox(height: size.height * .055),
                    _loginAccountLabel(context, color.primary),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: CustomIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () => context.pop(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      "Registro",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _loginAccountLabel(BuildContext context, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            '¿Ya tienes cuenta?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          CustomTextButton(label: "Autenticar", onPressed: (){
            context.pop();
          })
        ],
      ),
    );
  }
}