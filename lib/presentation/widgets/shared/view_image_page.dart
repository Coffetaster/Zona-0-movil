
import 'dart:io';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ViewImagePage extends StatelessWidget {
  const ViewImagePage({super.key, required this.url, required this.file, required this.tag, this.isAssets = false});

  final String url;
  final File? file;
  final String tag;
  final bool isAssets;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Hero(
            tag: tag,
            child: ExtendedImageSlidePage(
              slideAxis: SlideAxis.vertical,
              slideType: SlideType.onlyImage,
              slidePageBackgroundHandler: (offset, size){
                return defaultSlidePageBackgroundHandler(offset: offset, pageSize: size, color: Colors.black, pageGestureAxis: SlideAxis.vertical);
              },
              child: isAssets
              ? ExtendedImage.asset(
                  url,
                  mode: ExtendedImageMode.gesture,
                  enableSlideOutPage: true,
              )
              : ExtendedImage.network(
                  url,
                  mode: ExtendedImageMode.gesture,
                  enableSlideOutPage: true,
              )
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: IconButton(
            onPressed: (){
              context.pop();
            },
            icon: const Icon(Icons.close_outlined, color: Colors.white)))
      ],
    );
  }
  Color defaultSlidePageBackgroundHandler({required Offset offset, required Size pageSize, required Color color, required SlideAxis pageGestureAxis}) {
    double opacity = 0.0;
    if (pageGestureAxis == SlideAxis.both) {
      opacity = offset.distance /
          (Offset(pageSize.width, pageSize.height).distance / 2.0);
    } else if (pageGestureAxis == SlideAxis.horizontal) {
      opacity = offset.dx.abs() / (pageSize.width / 2.0);
    } else if (pageGestureAxis == SlideAxis.vertical) {
      opacity = offset.dy.abs() / (pageSize.height / 2.0);
    }
    return color.withOpacity(min(1.0, max(1.0 - opacity, 0.0)));
  }

  double? defaultSlideScaleHandler(
  {
    required Offset offset,
    required Size pageSize,
    required SlideAxis pageGestureAxis
  }){
    double scale = 0.0;
    if (pageGestureAxis == SlideAxis.both) {
      scale = offset.distance / Offset(pageSize.width, pageSize.height).distance;
    } else if (pageGestureAxis == SlideAxis.horizontal) {
      scale = offset.dx.abs() / (pageSize.width / 2.0);
    } else if (pageGestureAxis == SlideAxis.vertical) {
      scale = offset.dy.abs() / (pageSize.height / 2.0);
    }
    return max(1.0 - scale, 0.8);
  }
}