import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petcare/caches/shared_constant.dart';
import 'package:petcare/caches/shared_util.dart';
import 'package:petcare/config/common_config.dart';
import 'package:petcare/redux/reducer/locale_reducer.dart';
import 'package:petcare/redux/reducer/theme_reducer.dart';
import 'package:petcare/widgets/app_theme.dart';
import 'package:redux/redux.dart';

class FunctionUtils {
  static Locale curLocale;
  static setThemeData(Store store, int index) {
    ThemeData themeData = getThemeData(index);
    store.dispatch(RefreshThemeDataAction(themeData));
    store.dispatch(RefreshNightModalAction(index == 1));
  }

  static getThemeData(int index) {
    List<MaterialColor> colorList = CommonConfig.getThemeColors();
    return AppTheme.appTheme(isNight: index == 1, color: colorList[index]);
  }

  static initThemeData(Store store) async {
    int themeIndex = await SharedUtils.getInt(SharedConstant.themeColorIndex);
    if (themeIndex != null) {
      setThemeData(store, themeIndex);
    }
  }

  static changeLocale(Store store, int index) {
    Locale locale = store.state.platformLocale;
    switch (index) {
      case 0:
        locale = Locale.fromSubtags(languageCode: 'vi');
        break;
      case 1:
        locale = Locale.fromSubtags(languageCode: 'en');
        break;
    }
    curLocale = locale;
    store.dispatch(RefreshLocaleAction(locale));
  }

  static String fillInt(int number) {
    if (number < 10) {
      return '0$number';
    }
    return '$number';
  }
}
