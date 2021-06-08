import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/size_config.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;

final petRef = FirebaseFirestore.instance
    .collection('users/$uid/pets')
    .withConverter<PetModel>(
      fromFirestore: (snapshot, _) => PetModel.fromJson(snapshot.data()),
      toFirestore: (pet, _) => pet.toJson(),
    );
Future getListPet() async {
  QuerySnapshot petList = (await petRef.get());
  return petList.docs;
}

class PetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFit.screenHeight / 2.3,
      child: FutureBuilder(
        future: getListPet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                if (snapshot.data.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(text: "You have no pet."),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            //
                          }, //view pet detail
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: SizeFit.screenWidth * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue[50],
                                      offset: Offset(4, 6),
                                      blurRadius: 20,
                                    ),
                                  ]),
                              padding: EdgeInsets.only(top: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: Image(
                                        //load image from network with error handler
                                        image: NetworkImageWithRetry(
                                            snapshot.data[index]["petImg"]),
                                        errorBuilder:
                                            (context, exception, stackTrack) =>
                                                Icon(
                                          Icons.error,
                                        ),
                                      ),
                                      height: SizeConfig.screenHeight / 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: snapshot.data[index]["petName"],
                                          size: 22,
                                          color: ColorStyles.color_333333,
                                        ),
                                        Icon(
                                          snapshot.data[index]["sex"] == "Male"
                                              ? Icons.male
                                              : Icons.female,
                                          color: snapshot.data[index]["sex"] ==
                                                  "Male"
                                              ? Colors.lightBlueAccent
                                              : Colors.pinkAccent,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "Breed: " +
                                              snapshot.data[index]["petBreed"],
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: snapshot.data[index]
                                                  ["petWeight"] +
                                              " kg",
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
