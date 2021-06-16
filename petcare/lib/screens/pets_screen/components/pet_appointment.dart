import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/appointment_model.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/models/store_model.dart';
import 'package:petcare/models/user.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

final Map<String, String> serviceTypes = {
  'Pickup': 'Đến đón',
  'StoreVisit': 'Đi đến',
};
final currency = new NumberFormat("#,##0", "vi_VN");
final Map<String, String> availableTime = {
  '1': '7:00 - 8:30 ',
  '2': '9:00 - 10:30',
  '3': '13:30 - 13:00',
  '4': '15:00 - 16:30',
  '5': '16:00 - 17:30',
  '6': '18:00 - 19:30',
};
final Map<String, String> paymentMethods = {
  'credit': 'Credit Card',
  'cash': '    Cash    ',
  'net_banking': 'Net Banking',
};
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;
int selectedIndex;
final appointmentRef = FirebaseFirestore.instance
    .collection('appointments')
    .where("userId", isEqualTo: uid)
    .withConverter<AppointmentModel>(
      fromFirestore: (snapshot, _) =>
          AppointmentModel.fromJson(snapshot.data()),
      toFirestore: (appointment, _) => appointment.toJson(),
    );
final appointmentDetailRef = (String id) => FirebaseFirestore.instance
    .collection('appointments')
    .where("id", isEqualTo: id)
    .withConverter<AppointmentModel>(
      fromFirestore: (snapshot, _) =>
          AppointmentModel.fromJson(snapshot.data()),
      toFirestore: (appointment, _) => appointment.toJson(),
    );
final storeRef = (String id) => FirebaseFirestore.instance
    .collection('stores')
    .where("id", isEqualTo: id)
    .withConverter<StoreModel>(
      fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()),
      toFirestore: (store, _) => store.toJson(),
    );
final serviceRef = (String id) => FirebaseFirestore.instance
    .collection('stores/$id/services')
    .withConverter<PetServices>(
      fromFirestore: (snapshot, _) => PetServices.fromJson(snapshot.data()),
      toFirestore: (service, _) => service.toJson(),
    );
final userRef = (String id) => FirebaseFirestore.instance
    .collection('users')
    .where("uid", isEqualTo: id)
    .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()),
      toFirestore: (user, _) => user.toJson(),
    );
final petRef = (String id, String petId) => FirebaseFirestore.instance
    .collection('users/$id/pets')
    .where("id", isEqualTo: petId)
    .withConverter<PetModel>(
      fromFirestore: (snapshot, _) => PetModel.fromJson(snapshot.data()),
      toFirestore: (user, _) => user.toJson(),
    );

Future getListAppointments() async {
  QuerySnapshot appointmentList = (await appointmentRef.get());
  return appointmentList.docs;
}

Future getAppointmentDetail(String id) async {
  QuerySnapshot appointmentDetail = (await appointmentDetailRef(id).get());
  return appointmentDetail.docs;
}

Future getStoreDetail(String id) async {
  QuerySnapshot storeDetail = (await storeRef(id).get());
  return storeDetail.docs;
}

Future getServiceList(String id) async {
  QuerySnapshot serviceDetail = (await serviceRef(id).get());
  return serviceDetail.docs;
}

Future getUserDetail(String id) async {
  QuerySnapshot petDetail = (await userRef(id).get());
  return petDetail.docs;
}

Future getPetDetail(String id, String petId) async {
  QuerySnapshot petDetail = (await petRef(id, petId).get());
  return petDetail.docs;
}

class PetAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: SizeFit.screenHeight / 5,
          width: SizeFit.screenWidth * 0.9,
          child: FutureBuilder(
            future: getListAppointments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.length == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "Your pet has no appointment yet.",
                      color: Colors.grey,
                      size: 24,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              //view appointment detail
                              showModal(context, snapshot.data[index]["id"]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/background.png"),
                                      fit: BoxFit.none,
                                    ),
                                    color: ColorStyles.main_color,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue[50],
                                        offset: Offset(4, 6),
                                        blurRadius: 20,
                                      ),
                                    ]),
                                padding: EdgeInsets.only(top: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: "Cuộc hẹn sắp tới-" +
                                                  serviceTypes[
                                                      snapshot.data[index]
                                                          ["selectedType"]],
                                              size: 22,
                                              color: ColorStyles.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.medical_services,
                                              color: ColorStyles.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.access_time,
                                              color: ColorStyles.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: availableTime[snapshot
                                                  .data[index]["selectedTime"]],
                                              size: 16,
                                              color: ColorStyles.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: snapshot.data[index]
                                                      ["selectedDate"]
                                                  .split(" ")[0],
                                              size: 16,
                                              color: ColorStyles.white,
                                            ),
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
                  },
                );
              }
            },
          ),
        ),
      ],
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
                future: getAppointmentDetail(id),
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
                        children: <Widget>[
                          FutureBuilder(
                            future: getStoreDetail(snapshot.data[0]["storeId"]),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot2.hasError) {
                                return Text(snapshot2.error.toString());
                              } else {
                                return SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: CustomText(
                                            text: "Appointment Detail",
                                            size: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CustomText(
                                              text: "Store name:",
                                              size: 16,
                                              color: ColorStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CustomText(
                                              text: snapshot2.data[0]
                                                  ["storeName"],
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
                                              text: "Store address:",
                                              size: 16,
                                              color: ColorStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CustomText(
                                              text: snapshot2.data[0]
                                                  ["location"],
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
                                              text: "Selected services:",
                                              size: 16,
                                              color: ColorStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot
                                            .data[0]["selectedServiceIndex"]
                                            .length,
                                        itemBuilder: (_, index) {
                                          return FutureBuilder(
                                            future: getServiceList(
                                                snapshot.data[0]["storeId"]),
                                            builder: (context, snapshot3) {
                                              if (snapshot3.hasError) {
                                                return Text("Error happened.");
                                              } else {
                                                for (int i = 0;
                                                    i < snapshot3.data.length;
                                                    i++) {
                                                  print(i);
                                                  if (snapshot.data[0][
                                                              "selectedServiceIndex"]
                                                          [index] ==
                                                      snapshot3.data[i]["id"]) {
                                                    print(i);
                                                    selectedIndex = i;
                                                  }
                                                }
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: CustomText(
                                                    text: "- " +
                                                        snapshot3.data[
                                                                selectedIndex]
                                                            ["name"],
                                                    size: 16,
                                                    color: ColorStyles.black,
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CustomText(
                                              text: "Selected pet:",
                                              size: 16,
                                              color: ColorStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          FutureBuilder(
                                            future: getPetDetail(
                                                uid,
                                                snapshot.data[0]
                                                    ["selectedPetId"]),
                                            builder: (context, snapshot4) {
                                              if (snapshot4.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (snapshot4.hasError) {
                                                return Text(
                                                    snapshot4.error.toString());
                                              } else
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: CustomText(
                                                    text: snapshot4.data[0]
                                                        ["petName"],
                                                    size: 16,
                                                    color: ColorStyles.black,
                                                  ),
                                                );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          Divider(),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Your address:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: snapshot.data[0]["currentAddress"],
                              size: 16,
                              color: ColorStyles.black,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Appointment date:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["selectedDate"],
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
                                  text: "At:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: availableTime[snapshot.data[0]
                                      ["selectedTime"]],
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
                                  text: "Arrive method:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["selectedType"],
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
                                  text: "Payment method:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: paymentMethods[snapshot.data[0]
                                      ["paymentMethod"]],
                                  size: 16,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Total:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                    text:
                                        "${currency.format((snapshot.data[0]["totalPrice"]))} đ",
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
