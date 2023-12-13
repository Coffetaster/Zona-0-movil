// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:timelines/timelines.dart';

import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';

// * Instalar: timelines

class StepsWidgetGI extends HookWidget {
  StepsWidgetGI({
    super.key,
    required this.children,
    this.orientation = Axis.horizontal,
    this.index = 0,
    this.onTapFinish,
    this.textFinish,
  });

  final List<Widget> children;
  final Axis orientation;
  int index;
  int lastIndex = 0;
  final VoidCallback? onTapFinish;
  final String? textFinish;

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(index);
    final child = children[currentIndex.value % children.length];
    return orientation == Axis.horizontal
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _stepWidgetGI(
                  currentIndex: currentIndex.value,
                  child: child,
                  orientation: orientation,
                  isNext: currentIndex.value >= lastIndex),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  if (currentIndex.value > 0)
                    CustomFilledButton(
                        label: AppLocalizations.of(context)!.anterior,
                        onPressed: () {
                          lastIndex = currentIndex.value;
                          currentIndex.value--;
                        }),
                  CustomFilledButton(
                    label: currentIndex.value < children.length - 1
                        ? AppLocalizations.of(context)!.siguiente
                        : textFinish ?? AppLocalizations.of(context)!.terminar,
                    onPressed: () {
                      if (currentIndex.value < children.length - 1) {
                        lastIndex = currentIndex.value;
                        currentIndex.value++;
                      } else {
                        onTapFinish?.call();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: _timelineDots(
                    context: context,
                    currentIndex: currentIndex.value,
                    length: children.length),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .5,
                width: 50,
                child: _timelineDots(
                    context: context,
                    orientation: orientation,
                    currentIndex: currentIndex.value,
                    length: children.length),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _stepWidgetGI(
                      currentIndex: currentIndex.value,
                      child: child,
                      orientation: orientation,
                      isNext: currentIndex.value >= lastIndex),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      if (currentIndex.value > 0)
                        CustomFilledButton(
                            label: AppLocalizations.of(context)!.anterior,
                            onPressed: () {
                              lastIndex = currentIndex.value;
                              currentIndex.value--;
                            }),
                      CustomFilledButton(
                        label: currentIndex.value == children.length - 1
                            ? AppLocalizations.of(context)!.terminar
                            : AppLocalizations.of(context)!.siguiente,
                        onPressed: () {
                          lastIndex = currentIndex.value;
                          currentIndex.value++;
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
  }

  _stepWidgetGI(
      {required Widget child,
      required int currentIndex,
      Axis orientation = Axis.horizontal,
      bool isNext = true}) {
    if (isNext) {
      return orientation == Axis.horizontal
          ? FadeInRight(key: Key("stepWidgetGI$currentIndex"), child: child)
          : FadeInUp(key: Key("stepWidgetGI$currentIndex"), child: child);
    }
    return orientation == Axis.horizontal
        ? FadeInLeft(key: Key("stepWidgetGI$currentIndex"), child: child)
        : FadeInDown(key: Key("stepWidgetGI$currentIndex"), child: child);
  }
  // _stepWidgetGI(
  //     {required Widget child,
  //     Axis orientation = Axis.horizontal,
  //     bool isNext = true}) {
  // final rnd = Random();
  // final key = Key(rnd.nextInt(10000).toString());
  //   if (isNext) {
  //     return orientation == Axis.horizontal
  //         ? FadeInRight(key: key, child: child)
  //         : FadeInUp(key: key, child: child);
  //   }
  //   return orientation == Axis.horizontal
  //       ? FadeInLeft(key: key, child: child)
  //       : FadeInDown(key: key, child: child);
  // }

  _timelineDots(
      {required BuildContext context,
      required int currentIndex,
      required int length,
      Axis orientation = Axis.horizontal}) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);

    Color getColor(int index) {
      if (index == currentIndex) {
        return color.primary;
      } else if (index < currentIndex) {
        return color.secondaryContainer;
      } else {
        return color.secondary;
      }
    }

    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        direction: orientation,
        connectorTheme: const ConnectorThemeData(
          space: 30.0,
          thickness: 5.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtentBuilder: (_, __) => ((size.width / length) - 8),
        oppositeContentsBuilder: orientation == Axis.vertical
            ? (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppTheme.borderRadius))),
                    child: Text("${(index + 1).toString()}"),
                  ),
                );
              }
            : null,
        contentsBuilder: orientation == Axis.horizontal
            ? (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Paso ${(index + 1).toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getColor(index),
                    ),
                  ),
                );
              }
            : null,
        indicatorBuilder: (_, index) {
          var child;
          if (index == currentIndex) {
            child = const Icon(
              Icons.radio_button_off_outlined,
              color: Colors.white,
              size: 15.0,
            );
            // child = const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: CircularProgressIndicator(
            //     strokeWidth: 3.0,
            //     valueColor: AlwaysStoppedAnimation(Colors.white),
            //   ),
            // );
          } else if (index < currentIndex) {
            child = const Icon(
              Icons.check,
              color: Colors.white,
              size: 15.0,
            );
          }

          if (index <= currentIndex) {
            return Stack(
              children: [
                CustomPaint(
                  size: const Size(30.0, 30.0),
                  painter: _BezierPainter(
                    color: getColor(index),
                    drawStart: index > 0,
                    drawEnd: index < currentIndex,
                  ),
                ),
                index == currentIndex
                    ? Pulse(
                        child: DotIndicator(
                          size: 30.0,
                          color: getColor(index),
                          child: child,
                        ),
                      )
                    : DotIndicator(
                        size: 30.0,
                        color: getColor(index),
                        child: child,
                      ),
              ],
            );
          } else {
            return Stack(
              children: [
                CustomPaint(
                  size: const Size(15.0, 15.0),
                  painter: _BezierPainter(
                    color: getColor(index),
                    drawEnd: index < length - 1,
                  ),
                ),
                OutlinedDotIndicator(
                  borderWidth: 4.0,
                  color: getColor(index),
                ),
              ],
            );
          }
        },
        connectorBuilder: (_, index, type) {
          if (index > 0) {
            if (index == currentIndex) {
              final prevColor = getColor(index - 1);
              final color = getColor(index);
              List<Color> gradientColors;
              if (type == ConnectorType.start) {
                gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
              } else {
                gradientColors = [
                  prevColor,
                  Color.lerp(prevColor, color, 0.5)!
                ];
              }
              return DecoratedLineConnector(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                  ),
                ),
              );
            } else {
              return SolidLineConnector(
                color: getColor(index),
              );
            }
          } else {
            return null;
          }
        },
        itemCount: length,
      ),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
