import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_image/network.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/models/store_model.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/size_config.dart';
import 'package:petcare/widgets/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../create_pet.dart';
import 'checkout_screen.dart';

final currency = new NumberFormat("#,##0", "vi_VN");
final Map<String, String> serviceTypes = {
  'Pickup': 'Đến đón',
  'StoreVisit': 'Đi đến',
};
final Map<String, String> availableTime = {
  '1': '7:00 -8:30 ',
  '2': '9:00 -10:30',
  '3': '13:30-13:00',
  '4': '15:00-16:30',
  '5': '16:00-17:30',
  '6': '18:00-19:30',
};

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;

final storeRef =
    FirebaseFirestore.instance.collection('stores').withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()),
          toFirestore: (store, _) => store.toJson(),
        );
final servicesRef = (String storeId) => FirebaseFirestore.instance
    .collection('stores/$storeId/services')
    .withConverter<PetServices>(
      fromFirestore: (snapshot, _) => PetServices.fromJson(snapshot.data()),
      toFirestore: (service, _) => service.toJson(),
    );
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

Future getListStore() async {
  QuerySnapshot storeList = (await storeRef.get());
  return storeList.docs;
}

Future getListStoreServices(String storeId) async {
  QuerySnapshot serviceList = (await servicesRef(storeId).get());
  return serviceList.docs;
}

class BookServiceScreen extends StatefulWidget {
  final String currentAddress;
  final String currentStore;
  final String storeName;
  const BookServiceScreen(
      {this.currentAddress, this.currentStore, Key key, this.storeName})
      : super(key: key);

  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String _selectedType = serviceTypes.keys.first;
  String _selectedTime = availableTime.keys.first;
  int _selectedIndex = 0;
  List<String> _selectedServiceIndex = [];
  int _timeout = 999999;
  void setTimeout(int timeout) {
    setState(() {
      _timeout = timeout;
    });
  }

  bookService() {
    //createBookService();
    Toast.showSuccess('Info saved.');
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: CheckOutScreen()));
  }

  var today = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  void onServiceTypeSelected(String serviceTypeKey) {
    setState(() {
      _selectedType = serviceTypeKey;
    });
  }

  void onTimeSelected(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(seconds: _timeout),
        builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFDDAE4E7),
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () async {
              setState(() {
                _selectedServiceIndex = _selectedServiceIndex;
              });
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: AppLocalizations.of(context).selectLocationTitle,
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
                    text: "Select a pet",
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder(
                  future: getListPet(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        showModal(context);
                      },
                      child: Padding(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                child: Image(
                                  //load image from network with error handler
                                  image: NetworkImageWithRetry(
                                      snapshot.data[_selectedIndex]["petImg"]),
                                  errorBuilder:
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
                                ),
                                height: SizeConfig.screenHeight / 8,
                                width: SizeConfig.screenWidth / 4,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: snapshot.data[_selectedIndex]
                                            ["petName"],
                                        size: 22,
                                        color: ColorStyles.color_333333,
                                      ),
                                      Icon(
                                        snapshot.data[_selectedIndex]["sex"] ==
                                                "Male"
                                            ? Icons.male
                                            : Icons.female,
                                        color: snapshot.data[_selectedIndex]
                                                    ["sex"] ==
                                                "Male"
                                            ? Colors.lightBlueAccent
                                            : Colors.pinkAccent,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Breed: " +
                                            snapshot.data[_selectedIndex]
                                                ["petBreed"],
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: snapshot.data[_selectedIndex]
                                                ["petWeight"] +
                                            " kg",
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: "Selected",
                                      color: Colors.grey,
                                    ),
                                    Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: "Select pets service",
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder(
                  future: getListStoreServices(widget.currentStore),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data.length == 0) {
                      return Center(
                        child: CustomText(
                            text: "No services available.",
                            color: Colors.grey,
                            size: 20),
                      );
                    }
                    if (_selectedServiceIndex.isEmpty) {
                      return GestureDetector(
                        onTap: () {
                          showModalServices(widget.currentStore, context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: "No services selected yet.",
                                  color: Colors.grey,
                                  size: 20),
                              Icon(Icons.add_circle),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _selectedServiceIndex.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              showModalServices(widget.currentStore, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   child: Image(
                                      //     //load image from network with error handler
                                      //     image: NetworkImageWithRetry(
                                      //         snapshot.data[_selectedIndex]["image"]),
                                      //     errorBuilder: (context, exception, stackTrack) =>
                                      //         Icon(
                                      //       Icons.error,
                                      //     ),
                                      //   ),
                                      //   height: SizeConfig.screenHeight / 8,
                                      //   width: SizeConfig.screenWidth / 4,
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomText(
                                            text: snapshot.data[index]["name"],
                                            size: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          Text(" - "),
                                          CustomText(
                                            text: currency.format(snapshot
                                                    .data[index]["price"]) +
                                                "đ",
                                            size: 14,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              text: "Selected",
                                              color: Colors.grey,
                                            ),
                                            Icon(Icons.check_circle_outline,
                                                color: Colors.green),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: "Select date",
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    child: CupertinoDatePicker(
                      minimumDate: today,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime newDateTime) {},
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
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoRadioChoice(
                          choices: availableTime,
                          onChange: onTimeSelected,
                          initialKeyValue: _selectedTime,
                          selectedColor: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoRadioChoice(
                          choices: serviceTypes,
                          onChange: onServiceTypeSelected,
                          initialKeyValue: _selectedType,
                          selectedColor: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: ColorStyles.main_color,
                    child: MaterialButton(
                      minWidth: SizeFit.screenWidth,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        bookService();
                      },
                      child: CustomText(
                          text: "Book Now",
                          size: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void showModal(context) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (builder) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey[800],
            height: SizeFit.screenHeight * 0.54,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(right: 50.0, left: 50.0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
                    )),
                    child: Center(
                      child: CustomText(
                        text: 'Choose the Pet',
                        size: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FutureBuilder(
                          future: getListPet(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index) {
                                  if (snapshot.data.length == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CustomText(text: "No pet found."),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = index;
                                          print(petRef.get);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue[50],
                                                offset: Offset(4, 6),
                                                blurRadius: 10,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                child: Image(
                                                  //load image from network with error handler
                                                  image: NetworkImageWithRetry(
                                                      snapshot.data[index]
                                                          ["petImg"]),
                                                  errorBuilder: (context,
                                                          exception,
                                                          stackTrack) =>
                                                      Icon(
                                                    Icons.error,
                                                  ),
                                                ),
                                                height:
                                                    SizeConfig.screenHeight / 8,
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            snapshot.data[index]
                                                                ["petName"],
                                                        size: 22,
                                                        color: ColorStyles
                                                            .color_333333,
                                                      ),
                                                      Icon(
                                                        snapshot.data[0]
                                                                    ["sex"] ==
                                                                "Male"
                                                            ? Icons.male
                                                            : Icons.female,
                                                        color: snapshot.data[
                                                                        index]
                                                                    ["sex"] ==
                                                                "Male"
                                                            ? Colors
                                                                .lightBlueAccent
                                                            : Colors.pinkAccent,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                });
                          }),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 100.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(right: 50.0, left: 50.0, top: 20),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
                    )),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: CreatePetScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.add_circle),
                              CustomText(text: "Add new pet.", size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showModalServices(storeId, context) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (builder) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey[800],
            height: SizeFit.screenHeight * 0.54,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(right: 50.0, left: 50.0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
                    )),
                    child: Center(
                      child: CustomText(
                        text: 'Choose the pet services',
                        size: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FutureBuilder(
                          future: getListStoreServices(storeId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (_, index) {
                                    if (snapshot.data.length == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomText(
                                            text: "No services available."),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (!_selectedServiceIndex.contains(
                                                snapshot.data[index]["id"])) {
                                              _selectedServiceIndex.add(
                                                  snapshot.data[index]["id"]);
                                            } else {
                                              _selectedServiceIndex.remove(
                                                  snapshot.data[index]["id"]);
                                            }
                                            setTimeout(1);
                                            setTimeout(999999);
                                            print(_selectedServiceIndex);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: snapshot.data[index]
                                                                ["id"] !=
                                                            null &&
                                                        _selectedServiceIndex
                                                                .indexOf(snapshot
                                                                            .data[
                                                                        index]
                                                                    ["id"]) >=
                                                            0
                                                    ? Colors.lightBlueAccent
                                                    : Colors.white70,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.blue[50],
                                                    offset: Offset(4, 6),
                                                    blurRadius: 10,
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child:
                                                  // SizedBox(
                                                  //   child: Image(
                                                  //     //load image from network with error handler
                                                  //     image: NetworkImageWithRetry(
                                                  //         snapshot.data[index]
                                                  //             ["petImg"]),
                                                  //     errorBuilder: (context,
                                                  //             exception,
                                                  //             stackTrack) =>
                                                  //         Icon(
                                                  //       Icons.error,
                                                  //     ),
                                                  //   ),
                                                  //   height:
                                                  //       SizeConfig.screenHeight / 8,
                                                  //   width:
                                                  //       SizeConfig.screenWidth / 4,
                                                  // ),
                                                  Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: snapshot.data[index]
                                                        ["name"],
                                                    fontWeight: FontWeight.bold,
                                                    size: 22,
                                                    color: ColorStyles
                                                        .color_333333,
                                                  ),
                                                  CustomText(
                                                    text: currency.format(
                                                            snapshot.data[index]
                                                                ["price"]) +
                                                        "đ",
                                                    size: 20,
                                                    color: ColorStyles
                                                        .color_1a1a1a,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
