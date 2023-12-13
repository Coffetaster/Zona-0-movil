import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:zona0_apk/presentation/widgets/curves/bezierContainer.dart';

class BezierBackground extends StatelessWidget {
  const BezierBackground(
      {super.key, required this.child, this.btnBack = false, this.onPressed});

  final Widget child;
  final bool btnBack;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(color: color.primary),
            ),
            child,
            if (btnBack)
              Positioned(
                  top: 40,
                  left: 0,
                  child: CustomIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onPressed: onPressed ?? () => context.pop(),
                  )),
          ],
        ),
      ),
    );
  }
}
