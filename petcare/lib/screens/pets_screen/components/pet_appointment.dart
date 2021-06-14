import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare/models/appointment_model.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

final Map<String, String> serviceTypes = {
  'Pickup': 'Đến đón',
  'StoreVisit': 'Đi đến',
};
final Map<String, String> availableTime = {
  '1': '7:00 - 8:30 ',
  '2': '9:00 - 10:30',
  '3': '13:30 - 13:00',
  '4': '15:00 - 16:30',
  '5': '16:00 - 17:30',
  '6': '18:00 - 19:30',
};
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;

final appointmentRef = FirebaseFirestore.instance
    .collection('appointments')
    .withConverter<AppointmentModel>(
      fromFirestore: (snapshot, _) =>
          AppointmentModel.fromJson(snapshot.data()),
      toFirestore: (appointment, _) => appointment.toJson(),
    );
Future getListAppointments() async {
  QuerySnapshot appointmentList = (await appointmentRef.get());
  return appointmentList.docs;
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
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      if (snapshot.data.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CustomText(
                                text: "Your pet has no appointment yet.",
                                color: Colors.black),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {}, //view pet detail
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.access_time,
                                                  color: ColorStyles.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomText(
                                                  text: availableTime[
                                                      snapshot.data[index]
                                                          ["selectedTime"]],
                                                  size: 16,
                                                  color: ColorStyles.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                      }
                    },
                  );
                })),
      ],
    );
  }
}
