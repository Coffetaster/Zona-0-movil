import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .27,
          color: const Color(0xff15294a),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.balanceTotal,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6d7f99)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Consumer(
                        builder: (context, ref, child) {
                          final accountState = ref.watch(accountProvider);
                          return Text(
                            accountState.ospPoint.toStringAsFixed(2),
                            style: GoogleFonts.mulish(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xffe7ad03)),
                          );
                        },
                      ),
                      Text(
                        ' ${Constants.namePoints}',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xfffbbd5c).withAlpha(200)),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       'Eq:',
                  //       style: GoogleFonts.mulish(
                  //           textStyle: Theme.of(context).textTheme.headline4,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w600,
                  //           color: Color(0xff6d7f99)),
                  //     ),
                  //     Text(
                  //       ' \$10,000',
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.white),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //     width: 85,
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(12)),
                  //         border: Border.all(color: Colors.white, width: 1)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.add,
                  //           color: Colors.white,
                  //           size: 20,
                  //         ),
                  //         SizedBox(width: 5),
                  //         Text("Top up",
                  //             style: TextStyle(color: Colors.white)),
                  //       ],
                  //     ))
                ],
              ),
              const Positioned(
                left: -170,
                top: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Color(0xff3554d3),
                ),
              ),
              const Positioned(
                left: -160,
                top: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Color(0xff375efd),
                ),
              ),
              const Positioned(
                right: -170,
                bottom: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Color(0xffe7ad03),
                ),
              ),
              const Positioned(
                right: -160,
                bottom: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Color(0xfffbbd5c),
                ),
              )
            ],
          ),
        ));
  }
}
