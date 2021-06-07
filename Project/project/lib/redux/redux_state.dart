import 'package:flutter/material.dart';
import 'package:project/domain/models/config_info_model.dart';
import 'package:project/domain/models/divice_info_model.dart';
import 'package:project/redux/reducer/locale_reducer.dart';
import 'package:project/redux/reducer/theme_reducer.dart';
import 'package:project/redux/redux_index.dart';

import '../domain/models/pet_model.dart';

class ReduxState {
  ThemeData themeData;
  bool isNightModal;
  Locale locale;
  Locale platformLocale;
  bool isLogin;
  ConfigInfo configInfo;
  DeviceInfoModel deviceInfo;
  List<PetModel> petList;
  PetModel currentPet;

  ReduxState({
    this.locale,
    this.themeData,
    this.isNightModal,
    this.isLogin,
    this.configInfo,
    this.deviceInfo,
    this.petList,
    this.currentPet,
  });
}

ReduxState appReducer(ReduxState state, action) {
  return ReduxState(
    themeData: ThemeDataReducer(state.themeData, action),
    isNightModal: NightModalReducer(state.isNightModal, action),
    locale: LocaleReducer(state.locale, action),
  );
}
