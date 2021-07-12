import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/screens/basic_screen/basic_screen.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/size_config.dart';
import 'package:petcare/widgets/toast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;

final petDetailRef = (String id) => FirebaseFirestore.instance
    .collection('users/$uid/pets')
    .where("id", isEqualTo: id)
    .withConverter<PetModel>(
      fromFirestore: (snapshot, _) => PetModel.fromJson(snapshot.data()),
      toFirestore: (pet, _) => pet.toJson(),
    );
final petRef = FirebaseFirestore.instance
    .collection('users/$uid/pets')
    .where("status", isEqualTo: "alive")
    .withConverter<PetModel>(
      fromFirestore: (snapshot, _) => PetModel.fromJson(snapshot.data()),
      toFirestore: (pet, _) => pet.toJson(),
    );
Future getPetDetail(String id) async {
  QuerySnapshot petList = (await petDetailRef(id).get());
  return petList.docs;
}

Future getListPet() async {
  QuerySnapshot petList = (await petRef.get());
  return petList.docs;
}

class PetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFit.screenHeight / 2,
      child: FutureBuilder(
        future: getListPet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                  text: "You have no pet.", color: Colors.grey, size: 24),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModal(context, snapshot.data[index]["id"]);
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
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showModal(context, id) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (builder) {
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            color: Colors.grey[800],
            height: SizeFit.screenHeight * 0.8,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0)),
              ),
              child: FutureBuilder(
                future: getPetDetail(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Center(
                            child: CustomText(
                                text: "Pet Detail",
                                size: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  //load image from network with error handler
                                  image: NetworkImageWithRetry(
                                      snapshot.data[0]["petImg"]),
                                  errorBuilder:
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Name:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["petName"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Type:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["type"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Breed:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["petBreed"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Sex:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["sex"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Birthday/ Adoption day:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["birthday"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Weight:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["petWeight"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Description:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["description"],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('users/$uid/pets')
                                    .doc(snapshot.data[0]["id"])
                                    .update({"status": "removed"});
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: BasicScreen()));
                                Toast.showSuccess("Canceled.");
                              },
                              backgroundColor: Colors.red,
                              icon: Icon(
                                Icons.cancel_rounded,
                                size: 40,
                                color: ColorStyles.white,
                              ),
                              label: Text("Remove pet"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
