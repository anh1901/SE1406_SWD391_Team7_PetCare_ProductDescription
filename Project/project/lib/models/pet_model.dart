import 'dart:convert';

enum PetSex {
  male,
  female,
}

PetModel petModelFromJson(String str) => PetModel.fromJson(json.decode(str));

String petModelToJson(PetModel data) => json.encode(data.toJson());

class PetModel {
  String petImg;
  String petName;
  String petBreed;
  String sex;
  String birthday;
  String petWeight;
  String description;
  String type;

  PetModel({
    this.petImg,
    this.petName,
    this.petBreed,
    this.sex,
    this.birthday,
    this.petWeight,
    this.description,
    this.type,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        petImg: json["petImg"],
        petName: json["petName"],
        petBreed: json["petBreed"],
        sex: json["sex"],
        birthday: json["birthday"],
        petWeight: json["petWeight"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "petImg": petImg,
        "petName": petName,
        "petBreed": petBreed,
        "sex": sex,
        "birthday": birthday,
        "petWeight": petWeight,
        "type": type,
        "description": description,
      };
}
