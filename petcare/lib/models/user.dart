import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userFromJson(String str) {
  final jsonData = json.decode(str);
  return UserModel.fromJson(jsonData);
}

String userToJson(UserModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class UserModel {
  String uid;
  String username;
  String email;
  String status;
  String lastLocation;

  UserModel(
      {this.uid, this.username, this.email, this.status, this.lastLocation});

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        status: json["status"],
        lastLocation: json["lastLocation"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "status": status,
        "lastLocation": lastLocation,
      };

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel.fromJson(doc.data());
  }
}
