import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/backgrounds/bezier_background.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return BezierBackground(
      btnBack: true,
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
                const SizedBox(
                  height: 50,
                ),
                CustomCard(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: size.height * .4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(AppLocalizations.of(context)!.tipoRegistro,
                              style: Theme.of(context).textTheme.titleMedium),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconSubtextButton(
                                  icon: Icons.person_outline,
                                  label: AppLocalizations.of(context)!.cliente,
                                  onTap: () => context.push(RouterPath.AUTH_REGISTER_CLIENT_PAGE)),
                              IconSubtextButton(
                                  icon: Icons.factory_outlined,
                                  label: AppLocalizations.of(context)!.company,
                                  onTap: () => context.push(RouterPath.AUTH_REGISTER_COMPANY_PAGE)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    )),
                SizedBox(height: size.height * .055),
                _loginAccountLabel(context, color.primary),
              ],
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

  Widget _loginAccountLabel(BuildContext context, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.yaTienesCuenta,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          CustomTextButton(
              label: AppLocalizations.of(context)!.autenticar,
              onPressed: () {
                context.pop();
              })
        ],
      ),
    );
  }
}
