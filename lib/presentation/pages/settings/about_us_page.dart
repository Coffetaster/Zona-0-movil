import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: FadeInUp(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8),
    //       child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
    //         Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Image.asset(ImagesPath.logo.path, width: 120, height: 120),
    //             Text(
    //               "Orca Store",
    //               style: context.titleLarge,
    //             ),
    //             Text("1.9.6", style: context.bodyMedium),
    //           ],
    //         ),
    //         const SizedBox(height: 16),
    //         CustomCard(
    //             padding: EdgeInsets.all(8),
    //             child: ListTile(
    //               title: Text("Descripción"),
    //               subtitle: Text(
    //                   "Et cupidatat Lorem quis occaecat deserunt dolor occaecat esse eiusmod sunt mollit. Do dolore proident cupidatat dolor aute magna velit qui. Nisi adipisicing eu amet aliquip ex ea quis quis ullamco adipisicing Lorem. Minim minim et esse occaecat laborum aliquip ex. Occaecat enim commodo laboris veniam et tempor occaecat quis aliquip quis tempor magna anim. Duis do dolor labore culpa anim culpa ea proident ad officia amet eu excepteur officia.",
    //                   textAlign: TextAlign.justify),
    //             )),
    //         const Spacer(),
    //         Container(
    //           // color: Colors.red,
    //           width: double.infinity,
    //           height: 60,
    //           child: Center(
    //               child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text("Zona0 Devs", style: context.labelMedium),
    //               Text("Todos los derechos reservados",
    //                   style: context.bodySmall),
    //             ],
    //           )),
    //         )
    //       ]),
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        elevation: 0
      ),
      body: FadeInUp(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(ImagesPath.logo.path,
                                    width: 120, height: 120),
                                Text(
                                  "Orca Store",
                                  style: context.titleLarge,
                                ),
                                Text("1.9.6", style: context.bodyMedium),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomCard(
                                padding: EdgeInsets.all(8),
                                child: ListTile(
                                  title: Text("Descripción"),
                                  subtitle: Text(
                                      "Et cupidatat Lorem quis occaecat deserunt dolor occaecat esse eiusmod sunt mollit. Do dolore proident cupidatat dolor aute magna velit qui. Nisi adipisicing eu amet aliquip ex ea.",
                                      textAlign: TextAlign.justify),
                                )),
                          ],
                        )),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Zona0 Devs", style: context.labelMedium),
                          Text("Todos los derechos reservados",
                              style: context.bodySmall),
                        ],
                      )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
