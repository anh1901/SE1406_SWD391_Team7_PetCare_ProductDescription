import 'dart:convert';

class DeviceInfoModel {
  String mobileType;
  String mobileName;
  String mobileVersion;
  String modelType;
  String localizedModel;
  String mobileUid;
  bool isPhysicalDevice;

  DeviceInfoModel deviceInfoModelFromJson(String str) =>
      DeviceInfoModel.fromJson(json.decode(str));

  String deviceInfoModelToJson(DeviceInfoModel data) =>
      json.encode(data.toJson());
  DeviceInfoModel({
    this.mobileUid,
    this.isPhysicalDevice,
    this.mobileName,
    this.mobileVersion,
    this.mobileType,
    this.modelType,
    this.localizedModel,
  });
  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      DeviceInfoModel(
        mobileType: json["mobileType"] ?? '',
        mobileName: json["mobileName"] ?? '',
        mobileVersion: json["mobileVersion"] ?? '',
        modelType: json["modelType"] ?? '',
        localizedModel: json["localizedModel"] ?? '',
        mobileUid: json["mobileUID"] ?? '',
        isPhysicalDevice: json["isPhysicalDevice"] ?? false,
      );
  Map<String, dynamic> toJson() => {
        "mobileType": mobileType,
        "mobileName": mobileName,
        "mobileVersion": mobileVersion,
        "modelType": modelType,
        "localizedModel": localizedModel,
        "mobileUID": mobileUid,
        "isPhysicalDevice": isPhysicalDevice,
      };
}
