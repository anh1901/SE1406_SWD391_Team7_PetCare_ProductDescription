import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  String id;
  String sender;
  String date;
  String time;
  String message;

  EventModel({
    this.id,
    this.sender,
    this.date,
    this.time,
    this.message,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        sender: json["sender"],
        date: json["date"],
        time: json["time"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "date": date,
        "time": time,
        "message": message,
      };
}
