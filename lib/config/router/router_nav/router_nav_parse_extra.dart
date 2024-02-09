part of "router_nav.dart";

class RouterNavParseExtra {
  final Object? _extra;
  RouterNavParseExtra(this._extra);

  //* Agregar los parse a extra a partir de aquí
  Institution? get InstitutionDetailsPage =>
      (_extra != null && _extra is Institution) ? _extra as Institution : null;

  TransactionReceived? get ReceiveItemDataPage =>
      (_extra != null && _extra is TransactionReceived)
          ? _extra as TransactionReceived
          : null;

  User? get ProfilePage_User {
    if (_extra != null && _extra is Map) {
      final map = _extra as Map;
      if (map['user'] != null && map['user'] is User) {
        return map['user'] as User;
      }
    }
    return null;
  }

  String? get ProfilePage_UserImageTag {
    if (_extra != null && _extra is Map) {
      final map = _extra as Map;
      if (map['userImageTag'] != null && map['userImageTag'] is User) {
        return map['userImageTag'] as String;
      }
    }
    return null;
  }
}
