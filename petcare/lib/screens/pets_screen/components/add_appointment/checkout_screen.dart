import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/screens/basic_screen/basic_screen.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final Map<String, String> paymentMethods = {
  'credit': 'Credit Card',
  'cash': '    Cash    ',
  'net_banking': 'Net Banking',
};

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key key}) : super(key: key);

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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            text: "CVV",
                                            size: 16,
                                            color: ColorStyles.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            text: "123",
                                            size: 16,
                                            color: ColorStyles.color_666666,
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
                ),
              ),
              Container(
                height: SizeFit.screenHeight * 1 / 3,
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
                                    CustomText(text: "120.000đ"),
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
                                    CustomText(text: "20.000đ"),
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
                                    CustomText(text: "12.000đ"),
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
                                        text: "152.000đ",
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
                            confirmBooking();
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

  void confirmBooking() {
    //do something
    Toast.showToast("Booked");
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: BasicScreen()));
  }
}
