class ImagesPath {
  static final logo = ImagePath(path: 'assets/imagen/logo.png');
  static final user_placeholder =
      ImagePath(path: 'assets/imagen/user_placeholder.png');
  static final empty_cart = ImagePath(path: 'assets/imagen/empty_cart.png');
  static final new_notifications =
      ImagePath(path: 'assets/imagen/new_notifications.png');
  static final no_data = ImagePath(path: 'assets/imagen/no_data.png');
  static final sign_up = ImagePath(path: 'assets/imagen/sign_up.png');
  static final login = ImagePath(path: 'assets/imagen/login.png');
  static final pic_profile = ImagePath(path: 'assets/imagen/pic_profile.png');
}

class ImagePath {
  String path;
  ImagePath({
    required this.path,
  });
}
