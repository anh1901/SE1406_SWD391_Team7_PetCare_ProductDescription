import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Toast {
  static void showToast(String msg) {
    EasyLoading.showToast(msg);
  }

  static void showLoading() {
    EasyLoading.show(status: 'Loading...');
  }

  static void showSuccess(String msg) {
    EasyLoading.showSuccess(msg);
  }

  static void showError(String msg) {
    EasyLoading.showError(msg);
  }

  static void showWarn(String msg) {
    EasyLoading.showInfo(msg);
  }

  static void showProgress(double value, {String status = '正在保存...'}) {
    EasyLoading.showProgress(value, status: status);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void setToastStyle() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Color(0xCC000000)
      ..indicatorColor = Colors.white
      ..progressColor = Colors.white
      ..textColor = Colors.white
      ..fontSize = 15
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..userInteractions = false;
  }
}
