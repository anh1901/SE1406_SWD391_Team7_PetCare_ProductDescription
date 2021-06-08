import 'package:flutter/material.dart';

class AppointmentModel {
  final String name;
  final String date;
  final String time;
  final String serviceId;
  AppointmentModel(
      {@required this.name,
      @required this.date,
      @required this.time,
      @required this.serviceId});
}
