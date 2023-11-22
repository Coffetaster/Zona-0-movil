import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        color: color.primaryContainer,
        backgroundColor: color.background,
        items: const <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.search_outlined, size: 30),
          Icon(Icons.shopping_cart_outlined, size: 30),
          Icon(Icons.wallet_outlined, size: 30),
          Icon(Icons.settings_outlined, size: 30),
        ],
        onTap: (index) {
          switch(index){
            case 0:
              context.go(RouterPath.HOME_PAGE);
              break;
            case 1:
              context.go(RouterPath.FAVORITES_PAGE);
              break;
            case 2:
              context.go(RouterPath.WALLET_PAGE);
              break;
            case 3:
              context.go(RouterPath.SETTINGS_PAGE);
              break;
          }
        },
        letIndexChange: (index) => true,
      )
    );
  }
}
