import 'package:flutter/material.dart';

class PetServices {
  final String id;
  final String name;
  final int price;
  final String image;
  PetServices(
      {@required this.name,
      @required this.price,
      @required this.image,
      @required this.id});

  factory PetServices.fromJson(Map<String, dynamic> json) => PetServices(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
      };
}
