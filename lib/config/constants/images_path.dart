class ImagesPath {
  static final logo = ImagePath(path: 'assets/imagen/logo.png');
  static final user_placeholder = ImagePath(path: 'assets/imagen/user_placeholder.png');
}

class ImagePath {
  String path;
  ImagePath({
    required this.path,
  });
}