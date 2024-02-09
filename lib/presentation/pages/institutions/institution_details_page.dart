import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/show_image.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class InstitutionDetailsPage extends StatelessWidget {
  const InstitutionDetailsPage({super.key, required this.institution});

  final Institution? institution;

  @override
  Widget build(BuildContext context) {
    if (institution == null) {
      Future.delayed(const Duration(milliseconds: 0), () {
        context.pop();
      });
      return Container();
    }
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          body: _InstitutionGalleryView(context),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: Container(),
                onStretchTrigger: () async {},
                stretchTriggerOffset: 50.0,
                expandedHeight: context.height * 0.6,
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: ImageAndName(context),
                  ),
                ),
              ),
            ];
          }),
    );
  }

  Widget ImageAndName(BuildContext context) {
    List<ImageItem> imagesItem = institution!.galleryInstitution
        .map((e) => ImageItem(
            path: e.image, heroTag: HeroTags.imageGallery(e.id.toString())))
        .toList();
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: Text(AppLocalizations.of(context)!.informacion),
              centerTitle: true,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        ShowImage.fromNetwork(
                            context: context,
                            imagePath: institution!.image,
                            heroTag: HeroTags.institutionId(
                                institution!.id.toString()));
                      },
                      child: Hero(
                        tag: HeroTags.institutionId(institution!.id.toString()),
                        child: SizedBox(
                            width: context.width,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft:
                                      Radius.circular(AppTheme.borderRadius),
                                  topRight:
                                      Radius.circular(AppTheme.borderRadius)),
                              child: WidgetsGI.CacheImageNetworkGI(
                                  institution!.image,
                                  placeholderPath:
                                      ImagesPath.default_donation.path,
                                  width: 30,
                                  height: 30,
                                  // alignment: Alignment.bottomCenter,
                                  fit: BoxFit.cover),
                            )),
                      ),
                    ),
                  ),
                  ZoomIn(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: context.primary.withOpacity(.2),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppTheme.borderRadius))),
                      child: Text(
                        institution!.institution_name,
                        style:
                            context.headlineLarge.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
            )
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: FadeInRight(
            child: SizedBox(
              height: 125,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: institution!.galleryInstitution.length,
                itemBuilder: (context, index) {
                  final imageGallery = institution!.galleryInstitution[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: GestureDetector(
                      onTap: () {
                        if (imageGallery.image.isNotEmpty) {
                          ShowImage.showGalleryImage(
                              context: context,
                              imagesItem: imagesItem,
                              initialPage: index);
                        }
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: context.background,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  offset: Offset(1, 2),
                                )
                              ]),
                          child: Hero(
                            tag: HeroTags.imageGallery(
                                imageGallery.id.toString()),
                            placeholderBuilder: (context, heroSize, child) =>
                                child,
                            child: WidgetsGI.CacheImageNetworkGI(
                                imageGallery.image,
                                placeholderPath: ImagesPath.placeholder.path,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _InstitutionGalleryView(BuildContext context) {
    List<ImageItem> imagesItem = institution!.galleryInstitution
        .map((e) => ImageItem(
            path: e.image,
            heroTag: HeroTags.imageGallery(e.id.toString()) + '1'))
        .toList();
    return SingleChildScrollView(
      child: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.sobreNosotros),
                    subtitle: Text(
                      institution!.description,
                      textAlign: TextAlign.justify,
                    ),
                  )),
              const SizedBox(height: 8),
              CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(width: double.infinity),
                      Text(AppLocalizations.of(context)!.cantDonada,
                          style: context.labelLarge),
                      const SizedBox(height: 8),
                      Consumer(
                        builder: (context, ref, child) {
                          final donationsList = ref.watch(institutionsProvider
                              .select((value) => value.donationsList));
                          double total = 0;
                          for (Donation donation in donationsList) {
                            if (donation.institution ==
                                institution!.institution_name) {
                              total += donation.amount;
                            }
                          }
                          return Text(
                            "${total.toStringAsFixed(2)} OSP",
                            style: context.titleMedium,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CustomFilledButton(
                              label: AppLocalizations.of(context)!.donar,
                              onPressed: () {
                                DialogGI.showCustomDialog(context,
                                    dialog: DialogDonateInstitucion(
                                      institutionId: institution!.id.toString(),
                                    ));
                              }),
                          CustomFilledButton(
                              label:
                                  AppLocalizations.of(context)!.verDonaciones,
                              onPressed: () {
                                BottomSheetGI.showCustom(
                                    context: context,
                                    child: Consumer(
                                      builder: (context, ref, child) {
                                        final donationsList = ref
                                            .read(institutionsProvider.select(
                                                (value) => value.donationsList))
                                            .where((element) =>
                                                element.institution ==
                                                institution!.institution_name)
                                            .toList();
                                        if (donationsList.isEmpty) {
                                          return SizedBox(
                                            width: double.infinity,
                                            height: 300,
                                            child: Center(
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .noDonaciones)),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, right: 8, left: 8),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                width: 40,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: context.primary.withOpacity(.5),
                                                  borderRadius: const BorderRadius.all(Radius.circular(AppTheme.borderRadius))
                                                ),
                                              ),
                                              ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: donationsList.length,
                                                  itemBuilder: (context, index) =>
                                                      DonationItem(
                                                        donation:
                                                            donationsList[index],
                                                        canTap: false,
                                                      )),
                                            ],
                                          ),
                                        );
                                      },
                                    ));
                              })
                        ],
                      )
                    ],
                  )),
              const SizedBox(height: 16),
              const CustomTitle("Galería de imágenes"),
              MasonryGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: institution!.galleryInstitution.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _ImageGalleryItem(
                      index: index,
                      context: context,
                      imagesItem: imagesItem,
                      imageGallery: institution!.galleryInstitution[index]);
                  if (index == 1) {
                    return Column(
                      children: [
                        const SizedBox(width: double.infinity, height: 30),
                        item
                      ],
                    );
                  }
                  return item;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _ImageGalleryItem(
      {required int index,
      required BuildContext context,
      required List<ImageItem> imagesItem,
      required InstitutionGallery imageGallery}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: GestureDetector(
        onTap: () {
          if (imageGallery.image.isNotEmpty) {
            ShowImage.showGalleryImage(
                context: context, imagesItem: imagesItem, initialPage: index);
          }
        },
        child: Hero(
          tag: HeroTags.imageGallery(imageGallery.id.toString()) + '1',
          placeholderBuilder: (context, heroSize, child) => child,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              child: WidgetsGI.CacheImageNetworkGI(imageGallery.image,
                  placeholderPath: ImagesPath.placeholder.path,
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
