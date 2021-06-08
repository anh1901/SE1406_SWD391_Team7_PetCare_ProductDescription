import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/models/appointment_model.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

import 'add_appointment/map_screen.dart';

List<AppointmentModel> appointmentList = [
  AppointmentModel(
      name: "Medical Checkup",
      time: "9:00 AM",
      date: "20 January 2022",
      serviceId: "Health"),
  AppointmentModel(
      name: "Flea Treat",
      time: "12:30 PM",
      date: "25 January 2022",
      serviceId: "FleaTreat"),
];

class PetAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    CustomText(
                      text: "Pet's appointment",
                      size: 22,
                      color: ColorStyles.color_1a1a1a,
                    ),
                    CustomText(
                      text: " (${appointmentList.length})",
                      size: 18,
                      color: ColorStyles.color_1a1a1a,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: MapScreen()));
                },
                child: Icon(
                  Icons.add_circle,
                  size: 40,
                  color: ColorStyles.main_color,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: SizeFit.screenHeight / 6,
          width: SizeFit.screenWidth * 0.9,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: appointmentList.length,
            itemBuilder: (_, index) {
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
                                image:
                                    AssetImage("assets/images/background.png"),
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
                                        text: appointmentList[index].name,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        text: appointmentList[index].time,
                                        size: 16,
                                        color: ColorStyles.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text: appointmentList[index].date,
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
          ),
        ),
      ],
    );
  }
}
