import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

part "router_nav_path.dart";
part "router_nav_parse_extra.dart";
part "router_nav_parse_params.dart";

/*
  MODO DE USO
  + Para navegar y enviar de manera segura objetos entre pantallas
  1ra forma
  - En la clase RouterNavPath se debe crear las funciones donde
  va a recibir el objeto
  RouterNavMethod HomePage(User user) =>
      _build(RouterPath.HOME_PAGE,
          extra: user);

  - Para usarlo sería así
  context.nav.HomePage(user).push;

  2da forma
  - Puedes automatizar el enruteo si sabes que para una página siempre
  vas a usar por defecto el push, go o replace
  void pushHomePage(User user) =>
      _build(RouterPath.HOME_PAGE,
          extra: user).push;

  - Para usarlo sería así
  context.nav.pushHomePage(user);


  + Para parsear lo que se envíe de manera segura y ahorrar código
  - En la clase RouterNavParseExtra agregar los parse necesario por cada página
  que envíe un extra
  User? get HomePage =>
      (_extra != null && _extra is User) ? _extra as User : null;

  - En tu router mandar a parsear el extra recibido
  User? user = context.navParseExtra(extra).HomePage

*/

class RouterNavMethod<T> {
  final BuildContext _context;
  String _routerPath = "";
  Object? _extra = null;
  RouterNavMethod(this._context);

  RouterNavMethod build(String routerPath, {Object? extra}) {
    _routerPath = routerPath;
    _extra = extra;
    return this;
  }

  void get push => _context.push(_routerPath, extra: _extra);
  void get go => _context.go(_routerPath, extra: _extra);
  void get replace => _context.replace(_routerPath, extra: _extra);
}

extension RouterNav on BuildContext {
  RouterNavPath get nav => RouterNavPath(RouterNavMethod(this));
  RouterNavParseExtra navParseExtra(Object? extra) => RouterNavParseExtra(extra);
  RouterNavParseParams navParseParams(Map<String,String> params) => RouterNavParseParams(params);
}
