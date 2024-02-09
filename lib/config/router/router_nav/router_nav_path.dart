part of "router_nav.dart";

class RouterNavPath {
  final RouterNavMethod _routerNavMethod;
  RouterNavPath(this._routerNavMethod);

  RouterNavMethod _build(String routerPath, {Object? extra}) =>
      _routerNavMethod.build(routerPath, extra: extra);

  //* Agregar las rutas a partir de aquí

  //* InstitutionDetailsPage
  RouterNavMethod InstitutionDetailsPage(Institution institution) =>
      _build(RouterPath.INSTITUTIONS_DETAILS_PAGE, extra: institution);

  //* ReceiveItemDataPage
  RouterNavMethod ReceiveItemDataPage({
    required String id,
    TransactionReceived? transactionReceived,
    bool canEdit = true,
  }) =>
      _build(RouterPath.WALLET_RECEIVE_ITEM_DATA_PAGE(id, canEdit),
          extra: transactionReceived);

  //* ProfilePage
  RouterNavMethod ProfilePage({
    String? userImageTag,
    required User user,
  }) =>
      _build(RouterPath.USERS_PROFILE_PAGE, extra: {
        "userImageTag": userImageTag,
        "user": user,
      });
}
