import 'package:flutter/material.dart';
import 'package:petcare/models/config_info_model.dart';
import 'package:petcare/models/divice_info_model.dart';
import 'package:petcare/redux/reducer/locale_reducer.dart';
import 'package:petcare/redux/reducer/theme_reducer.dart';

import '../models/pet_model.dart';

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
