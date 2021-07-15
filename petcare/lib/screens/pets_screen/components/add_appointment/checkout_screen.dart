import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/models/appointment_model.dart';
import 'package:petcare/screens/basic_screen/basic_screen.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
final currency = new NumberFormat("#,##0", "vi_VN");
final Map<String, String> paymentMethods = {
  'credit': 'Credit Card',
  'cash': '    Cash    ',
  'net_banking': 'Net Banking',
};
final Map<String, String> availableTime = {
  '1': '7:00 - 8:30 ',
  '2': '9:00 - 10:30',
  '3': '13:30 - 13:00',
  '4': '15:00 - 16:30',
  '5': '16:00 - 17:30',
  '6': '18:00 - 19:30',
};

class CheckOutScreen extends StatefulWidget {
  final String storeId;
  final String storeName;
  final String currentAddress;
  final String selectedPetId;
  final String selectedDate;
  final String selectedTime;
  final String selectedType;
  final List<String> selectedServiceIndex;
  final double totalPrice;
  const CheckOutScreen(
      {Key key,
      this.storeId,
      this.currentAddress,
      this.selectedPetId,
      this.selectedDate,
      this.selectedTime,
      this.selectedType,
      this.selectedServiceIndex,
      this.totalPrice,
      this.storeName})
      : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String _selectedMethod = paymentMethods.keys.first;
  void onMethodSelected(String methodKey) {
    setState(() {
      _selectedMethod = methodKey;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Check out'),
            GestureDetector(
              onTap: () {
                //apply coupon
              },
              child: Icon(Icons.wallet_giftcard),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () async {
            setState(() {
              //
            });
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: SizeFit.screenHeight * 2 / 3,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Payment Method",
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoRadioChoice(
                                choices: paymentMethods,
                                onChange: onMethodSelected,
                                initialKeyValue: _selectedMethod,
                                selectedColor: Colors.lightBlueAccent,
                                notSelectedColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedMethod == "credit")
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "Your Cards",
                                    size: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //Add new credit card screen
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      text: "Add Card",
                                      size: 16,
                                      color: Colors.lightBlueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.check_circle_outline,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomText(
                                                  text: "XXXX XXXX XXXX 1234",
                                                  size: 16,
                                                  color: ColorStyles.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: "Visa",
                                              size: 16,
                                              color: ColorStyles.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.credit_card,
                                              color: Colors.lightBlueAccent,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: "VALID FROM",
                                              size: 14,
                                              color: ColorStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: "07/06",
                                              size: 14,
                                              color: ColorStyles.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              text: "NGUYEN VU TUAN ANH",
                                              size: 16,
                                              color: ColorStyles.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomText(
                                                  text: "CVV",
                                                  size: 16,
                                                  color: ColorStyles.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomText(
                                                  text: "123",
                                                  size: 16,
                                                  color:
                                                      ColorStyles.color_666666,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text:
                              AppLocalizations.of(context).selectLocationTitle,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[50],
                                  offset: Offset(4, 6),
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: widget.currentAddress,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Selected store",
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[50],
                                  offset: Offset(4, 6),
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: widget.storeName,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Selected date",
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[50],
                                  offset: Offset(4, 6),
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: widget.selectedDate,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Select Available Time",
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[50],
                                  offset: Offset(4, 6),
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: availableTime[widget.selectedTime],
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Service Types",
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[50],
                                  offset: Offset(4, 6),
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: widget.selectedType,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: SizeFit.screenHeight * 1 / 2.5,
                decoration: BoxDecoration(color: Colors.white70),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Subtotal:"),
                                    CustomText(
                                        text:
                                            "${currency.format(widget.totalPrice)} đ"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Shipping fee:"),
                                    CustomText(
                                        text:
                                            "${currency.format((widget.totalPrice * 0.2))} đ"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Tax:"),
                                    CustomText(
                                        text:
                                            "${currency.format((widget.totalPrice * 0.1))} đ"),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Total:"),
                                    CustomText(
                                        text:
                                            "${currency.format((widget.totalPrice * 1.3))} đ",
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: ColorStyles.main_color,
                        child: MaterialButton(
                          minWidth: SizeFit.screenWidth,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            confirmBooking(
                                widget.storeId,
                                widget.selectedDate,
                                widget.selectedTime,
                                widget.selectedType,
                                widget.totalPrice,
                                widget.selectedServiceIndex,
                                widget.selectedPetId,
                                widget.currentAddress,
                                _selectedMethod);
                          },
                          child: CustomText(
                              text: "Confirm booking",
                              size: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmBooking(
      String storeId,
      String selectedDate,
      String selectedTime,
      String selectedType,
      double totalPrice,
      List<String> selectedServiceIndex,
      String selectedPetId,
      String currentAddress,
      String selectedMethod) {
    addAppointment(
        storeId,
        selectedDate,
        selectedTime,
        selectedType,
        totalPrice,
        selectedServiceIndex,
        selectedPetId,
        currentAddress,
        selectedMethod);
    Toast.showToast("Booked");
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: BasicScreen()));
  }

  Future<void> addAppointment(
      String storeId,
      String selectedDate,
      String selectedTime,
      String selectedType,
      double totalPrice,
      List<String> selectedServiceIndex,
      String selectedPetId,
      String currentAddress,
      String selectedMethod) async {
    // Add a appointment
    await appointmentRef
        .add(
      AppointmentModel(
        storeId: storeId,
        userId: uid,
        currentAddress: currentAddress,
        selectedPetId: selectedPetId,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedServiceIndex: selectedServiceIndex,
        selectedType: selectedType,
        totalPrice: totalPrice,
        paymentMethod: selectedMethod,
        status: "alive",
      ),
    )
        .then((value) {
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(value.id)
          .update({"id": value.id});
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({"lastLocation": currentAddress}, SetOptions(merge: true));
    });
  }
}
