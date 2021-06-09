import 'dart:convert';

StoreModel storeModelFromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  String id;
  String storeImg;
  String storeName;
  String location;
  double rating;
  double distance;
  double rate;
  String description;

  StoreModel({
    this.id,
    this.storeImg,
    this.storeName,
    this.location,
    this.rating,
    this.distance,
    this.rate,
    this.description,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        storeImg: json["storeImg"],
        storeName: json["storeName"],
        location: json["location"],
        rating: json["rating"],
        distance: json["distance"],
        rate: json["rate"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storeImg": storeImg,
        "storeName": storeName,
        "location": location,
        "rating": rating,
        "distance": distance,
        "rate": rate,
        "description": description,
      };
}
