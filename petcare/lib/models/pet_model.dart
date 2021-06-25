import 'dart:convert';

enum PetSex {
  male,
  female,
}

PetModel petModelFromJson(String str) => PetModel.fromJson(json.decode(str));

String petModelToJson(PetModel data) => json.encode(data.toJson());

class PetModel {
  String id;
  String petImg;
  String petName;
  String petBreed;
  String sex;
  String birthday;
  String petWeight;
  String description;
  String type;
  String status;

  PetModel({
    this.id,
    this.petImg,
    this.petName,
    this.petBreed,
    this.sex,
    this.birthday,
    this.petWeight,
    this.description,
    this.type,
    this.status,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        id: json["id"],
        petImg: json["petImg"],
        petName: json["petName"],
        petBreed: json["petBreed"],
        sex: json["sex"],
        birthday: json["birthday"],
        petWeight: json["petWeight"],
        type: json["type"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petImg": petImg,
        "petName": petName,
        "petBreed": petBreed,
        "sex": sex,
        "birthday": birthday,
        "petWeight": petWeight,
        "type": type,
        "description": description,
        "status": status,
      };
}
