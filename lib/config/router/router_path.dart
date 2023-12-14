

class RouterPath {
  static const String INITIAL_PAGE = '/';

  //* Home pages
  static const String HOME_PAGE_PATH = '/home/:page';
  static const String HOME_PAGE = '/home/0';
  static const String CATEGORIES_PAGE = '/home/1';
  static const String SHOPPING_CART_PAGE = '/home/2';
  static const String WALLET_PAGE = '/home/3';
  static const String SETTINGS_PAGE = '/home/4';

  static const String SEARCH_PAGE = '/search';

  //* Products pages
  static const String PRODUCT_DETAIL_PAGE_PATH = '/product/:id';
  static String PRODUCT_DETAIL_PAGE(id) => '/product/${id.toString()}';

  //* Auth pages
  static const String AUTH_LOGIN_PAGE = '/auth/login';
  static const String AUTH_REGISTER_PAGE = '/auth/register';
  static const String AUTH_REGISTER_CLIENT_PAGE_PATH = 'client';
  static const String AUTH_REGISTER_CLIENT_PAGE = '$AUTH_REGISTER_PAGE/$AUTH_REGISTER_CLIENT_PAGE_PATH';
  static const String AUTH_REGISTER_COMPANY_PAGE_PATH = 'company';
  static const String AUTH_REGISTER_COMPANY_PAGE = '$AUTH_REGISTER_PAGE/$AUTH_REGISTER_COMPANY_PAGE_PATH';
  static const String AUTH_VERIFY_CODE_PAGE = '/verify_code';

  //* Wallet pages
  static const String WALLET_TRANSFER_PAGE = '/wallet/transfer';

}