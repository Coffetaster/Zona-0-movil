import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';

class DoblePage extends StatefulWidget {
  DoblePage({super.key});

  @override
  State<DoblePage> createState() => _DoblePageState();
}

class _DoblePageState extends State<DoblePage> {
  final PanelController _panelController = PanelController();

  bool isPanelOpen() =>
      (_panelController.isAttached && _panelController.isPanelOpen);

  bool isPanelOpenAnimation = false;
  double appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );
    return PopScope(
      canPop: !isPanelOpenAnimation,
      onPopInvoked: (canPop) {
        if (!canPop) {
            _panelController.close();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: SlidingUpPanel(
          controller: _panelController,
          borderRadius: isPanelOpenAnimation ? null : radius,
          minHeight: context.height * .3,
          maxHeight: context.height - appBarHeight - 20,
          onPanelSlide: (position) {
            if (isPanelOpenAnimation && position < 0.95) {
              setState(() => isPanelOpenAnimation = false);
            } else if (!isPanelOpenAnimation && position >= 0.95) {
              setState(() => isPanelOpenAnimation = true);
            }
          },
          panel: const Center(
            child: Text("Culpa cillum exercitation ad exercitation."),
          ),
          body: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const Text("AppBar title 1"),
                ),
                body: Center(
                  child: FilledButton(
                      child: const Text("Abrir Panel"),
                      onPressed: () {
                        _panelController.open();
                        setState(() {});
                      }),
                ),
              ),
              if (isPanelOpenAnimation)
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SlideInDown(
                      duration: const Duration(milliseconds: 100),
                      child: AppBar(
                        title: const Text("AppBar title 2"),
                        leading: IconButton(
                            onPressed: () async {
                              if (isPanelOpen()) {
                                await _panelController.close();
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                    ))
            ],
          ),
          collapsed: Container(
            decoration: BoxDecoration(
                color: context.secondary,
                borderRadius: isPanelOpenAnimation ? null : radius),
            child: Center(
              child: Column(
                children: [
                  ShakeY(
                    duration: const Duration(milliseconds: 5000),
                    infinite: true,
                    from: 4,
                    child: IconButton(
                      icon: const Icon(Icons.keyboard_arrow_up_outlined),
                      color: context.onSecondary,
                      onPressed: () {
                        _panelController.open();
                      },
                    ),
                  ),
                  Text(
                    "Desliza hacia arriba",
                    style: context.labelLarge
                        .copyWith(color: context.onSecondary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
