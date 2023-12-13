import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class NoLoginAlert extends StatelessWidget {
  const NoLoginAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))
            ),
            child: Icon(Icons.login_outlined, size: 30,)),
            SizedBox(
              height: 10,
            ),
          Text(
            AppLocalizations.of(context)!.debeAutenticarse,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
              height: 10,
            ),
          CustomGradientButton(label: AppLocalizations.of(context)!.autenticar, onPressed: () => context.go(RouterPath.AUTH_LOGIN_PAGE))
        ],
      ),
    );
  }
}