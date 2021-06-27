import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/widgets/custom_text.dart';

import '../../../../pets_screen.dart';

final serviceRef = (String id) => FirebaseFirestore.instance
    .collection('stores/$id/services')
    .where("status", isEqualTo: "alive")
    .withConverter<PetServices>(
      fromFirestore: (snapshot, _) => PetServices.fromJson(snapshot.data()),
      toFirestore: (service, _) => service.toJson(),
    );

Future getServiceList(String id) async {
  QuerySnapshot serviceDetail = (await serviceRef(id).get());
  return serviceDetail.docs;
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({this.price, this.name, this.storeId, Key key})
      : super(key: key);
  final String storeId;
  final String name;
  final int price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Image.asset(
                  name == "Pet Sitting"
                      ? "assets/images/pet_sitting.png"
                      : (name == "Medical Checkup"
                          ? "assets/images/health_pet.png"
                          : (name == "Flea Treat"
                              ? "assets/images/bug.png"
                              : "assets/images/grooming.png")),
                  height: 40,
                  width: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: name,
                    size: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  Text("${currency.format((price))} đ"),
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
