import 'dart:convert';

import 'package:project/caches/shared_constant.dart';
import 'package:project/caches/shared_util.dart';
import 'package:project/domain/models/config_info_model.dart';
import 'package:project/domain/models/divice_info_model.dart';
import 'package:project/domain/models/pet_model.dart';

import 'data_result.dart';

class SharedStorage {
  static ConfigInfo configInfo = ConfigInfo();
  static DeviceInfoModel deviceInfo = DeviceInfoModel();

  static bool showWelcome = false;
  static bool showLogin = false;
  static Future initStorage() async {
    showWelcome = await SharedUtils.getBool(SharedConstant.welcomePage);
    showLogin = await SharedUtils.getBool(SharedConstant.isLogin);
  }

  static saveDeviceInfo() {
    SharedUtils.setString("deviceInfo", jsonEncode(deviceInfo?.toJson()));
  }

  static getConfigInfoLocal() async {
    var _configInfo = await SharedUtils.getString(SharedConstant.configInfo);

    if (_configInfo != null && _configInfo != '') {
      var dataInfo = json.decode(_configInfo);
      ConfigInfo data = ConfigInfo.fromJson(dataInfo);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getCurrentModel() async {
    var _petModel = await SharedUtils.getString(SharedConstant.petModel);

    if (_petModel != null && _petModel != '') {
      var jsonData = json.decode(_petModel);
      PetModel data = PetModel.fromJson(jsonData);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getDeviceInfoLocal() async {
    var _deviceInfo = await SharedUtils.getString(SharedConstant.deviceInfo);

    if (_deviceInfo != null && _deviceInfo != '') {
      var dataInfo = json.decode(_deviceInfo);
      DeviceInfoModel data = DeviceInfoModel.fromJson(dataInfo);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static saveShowWelcome() {
    SharedUtils.setBool(SharedConstant.welcomePage, true);
  }
}
