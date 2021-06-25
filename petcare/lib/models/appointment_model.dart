class AppointmentModel {
  final String id;
  final String storeId;
  final String userId;
  final String currentAddress;
  final String selectedPetId;
  final String selectedDate;
  final String selectedTime;
  final String selectedType;
  final List<String> selectedServiceIndex;
  final double totalPrice;
  final String paymentMethod;
  final String status;
  AppointmentModel({
    this.id,
    this.storeId,
    this.userId,
    this.currentAddress,
    this.selectedPetId,
    this.selectedDate,
    this.selectedTime,
    this.selectedType,
    this.selectedServiceIndex,
    this.totalPrice,
    this.paymentMethod,
    this.status,
  });
  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json["id"],
        storeId: json["storeId"],
        userId: json["userId"],
        currentAddress: json["currentAddress"],
        selectedPetId: json["selectedPetId"],
        selectedDate: json["selectedDate"],
        selectedTime: json["selectedTime"],
        selectedServiceIndex: json["selectedServiceIndex"],
        selectedType: json["selectedType"],
        totalPrice: json["totalPrice"],
        paymentMethod: json["paymentMethod"],
        status: json["status"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "storeId": storeId,
        "userId": userId,
        "currentAddress": currentAddress,
        "selectedPetId": selectedPetId,
        "selectedDate": selectedDate,
        "selectedTime": selectedTime,
        "selectedType": selectedType,
        "selectedServiceIndex": selectedServiceIndex,
        "totalPrice": totalPrice,
        "paymentMethod": paymentMethod,
        "status": status,
      };
}
