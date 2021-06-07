import 'dart:io';
import 'dart:ui';

class SizeFit {
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;
  static double physicalWidth;
  static double physicalHeight;
  static double screenWidth;
  static double screenHeight;
  static double statusHeight;
  static double navHeight;
  static double safeHeight;
  static double tabBarHeight;
  static bool isIPhoneX;
  static double dpr;
  static double rpx;
  static double px;

  static void initialize({double standardSize = 750}) {
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;
    dpr = window.devicePixelRatio;

    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;
    statusHeight = window.padding.top / dpr;
    isIPhoneX = screenHeight >= 812;
    navHeight = statusHeight + 44;
    tabBarHeight = isIPhoneX ? 83 : 49;
    safeHeight = isIPhoneX ? 34 : 0;
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static double setRpx(double size) {
    return rpx * size;
  }

  static double setPx(double size) {
    return px * size;
  }
}
