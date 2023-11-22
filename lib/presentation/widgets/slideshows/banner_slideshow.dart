import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/promo.dart';
import 'package:zona0_apk/presentation/widgets/shared/widgets_gi.dart';

class BannerSlideshow extends StatelessWidget {

  final List<Promo> promos;

  const BannerSlideshow({super.key, required this.promos});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.surfaceVariant
          )
        ),
        itemCount: promos.length,
        itemBuilder: (context, index) => _Slide(promo: promos[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Promo promo;
  const _Slide({required this.promo});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(5, 10),
        )
      ]
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(promo.image, fit: BoxFit.cover,),
          // child: WidgetsGI.CacheImageNetworkGI(promo.image),
        ),
      ),
    );
  }
}