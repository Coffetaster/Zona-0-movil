import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/router/router_nav/router_nav.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class InstitutionItem extends StatelessWidget {
  const InstitutionItem({super.key, required this.institution});

  final Institution institution;

  @override
  Widget build(BuildContext context) {
    // final widthMiniImg = context.width * .25;
    return CustomCard(
      child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: HeroTags.institutionId(institution.id.toString()),
                        child: SizedBox(
                            width: double.infinity,
                            height: 185,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft:
                                        Radius.circular(AppTheme.borderRadius),
                                    topRight:
                                        Radius.circular(AppTheme.borderRadius)),
                                // borderRadius: BorderRadius.circular(
                                //     AppTheme.borderRadius),
                                child: WidgetsGI.CacheImageNetworkGI(
                                    institution.image,
                                    placeholderPath:
                                        ImagesPath.default_donation.path,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover))),
                      ),
                      // if (institution.galleryInstitution.isNotEmpty)
                      //   Positioned(
                      //     bottom: 0,
                      //     left: 0,
                      //     right: 0,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         ...institution.galleryInstitution
                      //             .getRange(
                      //                 0,
                      //                 institution.galleryInstitution.length <= 3
                      //                     ? institution
                      //                         .galleryInstitution.length
                      //                     : 3)
                      //             .map(
                      //               (e) => ClipRRect(
                      //                 borderRadius: BorderRadius.circular(
                      //                     AppTheme.borderRadius),
                      //                 child: WidgetsGI.CacheImageNetworkGI(
                      //                   e.image,
                      //                   fit: BoxFit.cover,
                      //                   width: widthMiniImg,
                      //                   height: widthMiniImg,
                      //                 ),
                      //               ),
                      //             ),
                      //       ],
                      //     ),
                      //   ),
                    ],
                  )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      institution.institution_name,
                      style: context.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                  CustomOutlinedButton(
                      label: AppLocalizations.of(context)!.visitar,
                      onPressed: () {
                        context.nav.InstitutionDetailsPage(institution).push;
                      })
                ],
              )),
            ],
          )),
    );
  }
}
