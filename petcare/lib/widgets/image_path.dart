class ImagePath {
  static const image_path = 'assets/images/';
  static String asset(String path) {
    return image_path + path + '.png';
  }
}
