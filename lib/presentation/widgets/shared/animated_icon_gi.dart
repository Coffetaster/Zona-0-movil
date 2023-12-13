import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//* provider ini
final animatedIconGIProvider = StateNotifierProvider
  .autoDispose.family<AnimatedIconGINotifier,bool,String>(
  (ref, id) {
  return AnimatedIconGINotifier();
});

class AnimatedIconGINotifier extends StateNotifier<bool> {
  AnimatedIconGINotifier(): super(true);

  void toggleAnim() {
    state = !state;
  }
}
//* provider fin

class AnimatedIconGI extends ConsumerStatefulWidget {
  const AnimatedIconGI({
    super.key,
    required this.id,
    required this.icon,
    this.durationInMillis,
    this.color,
  });
  final String id;
  final AnimatedIconData icon;
  final int? durationInMillis;
  final Color? color;

  @override
  _AnimatedIconGIState createState() => _AnimatedIconGIState();
}

class _AnimatedIconGIState extends ConsumerState<AnimatedIconGI> with SingleTickerProviderStateMixin{

  late AnimationController controller;

  _AnimatedIconGIState();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMillis ?? 200)
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(animatedIconGIProvider(widget.id),
      (previous, next) {
        next ? controller.reverse() : controller.forward();
    });
    return AnimatedIcon(
      icon: widget.icon,
      progress: controller,
      color: widget.color ?? Colors.white,
    );
  }
}