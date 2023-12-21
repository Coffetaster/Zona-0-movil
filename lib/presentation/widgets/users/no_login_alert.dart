import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class NoLoginAlert extends StatelessWidget {
  const NoLoginAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Image.asset(ImagesPath.login.path,
                  width: size.width * .5,
                  height: size.width * .5,
                  fit: BoxFit.contain),
          // Container(
          //     padding: EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //         color: Theme.of(context).colorScheme.secondaryContainer,
          //         borderRadius:
          //             BorderRadius.all(Radius.circular(AppTheme.borderRadius))),
          //     child: Image.asset(ImagesPath.login.path,
          //         width: size.width * .5,
          //         height: size.width * .5,
          //         fit: BoxFit.contain)),
          Text(
            AppLocalizations.of(context)!.debeAutenticarse,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          CustomGradientButton(
              label: AppLocalizations.of(context)!.autenticar,
              onPressed: () => context.go(RouterPath.AUTH_LOGIN_PAGE))
        ],
      ),
    );
  }
}
