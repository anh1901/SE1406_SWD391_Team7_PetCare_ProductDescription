import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/caches/shared_storage.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/models/store_model.dart';
import 'package:petcare/redux/redux_state.dart';
import 'package:petcare/screens/pets_screen/components/pet_services.dart';
import 'package:petcare/screens/pets_screen/components/store_detail/store_detail_page.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/add_appointment/book_service_screen.dart';
import 'components/add_appointment/map_screen.dart';
import 'components/pet_appointment.dart';
import 'components/pet_list.dart';
import 'create_pet.dart';

final currency = new NumberFormat("#,##0", "vi_VN");
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;
final storeRef = FirebaseFirestore.instance
    .collection('stores')
    .where("status", isEqualTo: "alive")
    .withConverter<StoreModel>(
      fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()),
      toFirestore: (store, _) => store.toJson(),
    );
final storeDetailRef = (String id) => FirebaseFirestore.instance
    .collection('stores')
    .where("id", isEqualTo: id)
    .withConverter<StoreModel>(
      fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()),
      toFirestore: (store, _) => store.toJson(),
    );
final serviceRef = (String id) => FirebaseFirestore.instance
    .collection('stores/$id/services')
    .where("status", isEqualTo: "alive")
    .withConverter<PetServices>(
      fromFirestore: (snapshot, _) => PetServices.fromJson(snapshot.data()),
      toFirestore: (service, _) => service.toJson(),
    );

Future getServiceList(String id) async {
  QuerySnapshot serviceDetail = (await serviceRef(id).get());
  return serviceDetail.docs;
}

Future getListStore() async {
  QuerySnapshot storeList = (await storeRef.get());
  return storeList.docs;
}

Future getStoreDetail(String id) async {
  QuerySnapshot storeList = (await storeDetailRef(id).get());
  return storeList.docs;
}

class PetsScreen extends StatefulWidget {
  const PetsScreen({Key key}) : super(key: key);

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final isTutorial = SharedStorage.showTutorial;
  final scrollController = ScrollController();
  // GlobalKey _appointmentKey = GlobalObjectKey("appointmentKey");
  // GlobalKey _petsKey = GlobalObjectKey("petKey");
  @override
  void initState() {
    super.initState();
    // _loadCoachMark();
  }

  // Future<void> _loadCoachMark() async {
  //   print(isTutorial);
  //   if (!isTutorial) {
  //     Timer(Duration(seconds: 1), () => showCoachMarkApppointment());
  //   }
  // }
  // void showCoachMarkApppointment() {
  //   CoachMark coachMarkFAB = CoachMark();
  //   RenderBox target = _appointmentKey.currentContext.findRenderObject();
  //   Rect markRect = target.localToGlobal(Offset.zero) & target.size;
  //   markRect = Rect.fromCircle(
  //       center: markRect.center, radius: markRect.longestSide * 0.6);
  //
  //   coachMarkFAB.show(
  //       targetContext: _appointmentKey.currentContext,
  //       markRect: markRect,
  //       children: [
  //         Center(
  //             child: Text("Tap to add\na new appointment",
  //                 style: const TextStyle(
  //                   fontSize: 24.0,
  //                   fontStyle: FontStyle.italic,
  //                   color: Colors.white,
  //                 )))
  //       ],
  //       duration: Duration(seconds: 3),
  //       onClose: () {
  //         Timer(Duration(seconds: 1), () => showCoachMarkPet());
  //       });
  // }
  //
  // void showCoachMarkPet() {
  //   CoachMark coachMarkTile = CoachMark();
  //   RenderBox target = _petsKey.currentContext.findRenderObject();
  //   Rect markRect = target.localToGlobal(Offset.zero) & target.size;
  //   markRect = markRect.inflate(5.0);
  //   coachMarkTile.show(
  //       targetContext: _appointmentKey.currentContext,
  //       markRect: markRect,
  //       markShape: BoxShape.rectangle,
  //       children: [
  //         Positioned(
  //             top: markRect.bottom + 15.0,
  //             right: 5.0,
  //             child: Text("Tap on button\nto add a pet",
  //                 style: const TextStyle(
  //                   fontSize: 24.0,
  //                   fontStyle: FontStyle.italic,
  //                   color: Colors.white,
  //                 )))
  //       ],
  //       duration: Duration(seconds: 3),
  //       onClose: () {
  //         SharedStorage.saveShowTutorial();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(builder: (context, store) {
      return Scaffold(
          body: SafeArea(
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0, top: 10.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).hello,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder(
                            future: getUserDetail(uid),
                            builder: (context, snapshot) {
                              return Text(
                                // " " + snapshot.data[0]["username"],
                                " User",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue[200],
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomText(
                          text: AppLocalizations.of(context).petsScreenTitle,
                          size: 18,
                          color: ColorStyles.color_666666,
                        ),
                      ),
                    ),
                  ],
                ),
                PetServicesList(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: CustomText(
                        text: AppLocalizations.of(context).stores,
                        size: 22,
                        color: ColorStyles.color_1a1a1a,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: CustomText(
                          text: "View more",
                          color: ColorStyles.main_color,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: SizeFit.screenHeight / 2.2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: FutureBuilder(
                        future: getListStore(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                if (snapshot.data.length == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                        text: AppLocalizations.of(context)
                                            .noStoreAvailable),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: StoreDetailPage(
                                                  snapshot.data[index]["id"])));
                                      // showModal(
                                      //     context, snapshot.data[index]["id"]);
                                    },
                                    child: Container(
                                      width: SizeFit.screenWidth * 0.8,
                                      child: Stack(
                                        children: <Widget>[
                                          Hero(
                                            tag: Key("key" +
                                                snapshot.data[index]
                                                    ["imageUrl"]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image(
                                                  width:
                                                      SizeFit.screenWidth * 0.8,
                                                  height: SizeFit.screenHeight /
                                                      3.5,
                                                  fit: BoxFit.cover,
                                                  //load image from network with error handler
                                                  image: NetworkImageWithRetry(
                                                      snapshot.data[index]
                                                          ["imageUrl"]),
                                                  errorBuilder: (context,
                                                          exception,
                                                          stackTrack) =>
                                                      Icon(
                                                    Icons.error,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Card(
                                              elevation: 8,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              margin: const EdgeInsets.only(
                                                  top: 200),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8)),
                                                            color: Colors.green,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        8),
                                                            child: Text(
                                                              'ON DISCOUNT',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              text: snapshot
                                                                  .data[index]
                                                                      ["rate"]
                                                                  .toString(),
                                                              size: 16,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ListTile(
                                                    title: CustomText(
                                                      text: snapshot.data[index]
                                                          ["storeName"],
                                                      size: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorStyles
                                                          .color_333333,
                                                    ),
                                                    subtitle: CustomText(
                                                        size: 14,
                                                        color: Colors.grey,
                                                        text:
                                                            "${snapshot.data[index]["location"]}"),
                                                    trailing: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .lightGreenAccent,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Transform.rotate(
                                                        angle: 0,
                                                        child: IconButton(
                                                          icon: Icon(Icons
                                                              .map_outlined),
                                                          onPressed: () {},
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text:
                                  AppLocalizations.of(context).petsAppointment,
                              size: 22,
                              color: ColorStyles.color_1a1a1a,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: CustomText(
                                  text: "View all",
                                  color: ColorStyles.main_color,
                                  size: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                PetAppointment(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: CustomText(
                        text: AppLocalizations.of(context).myPets,
                        size: 22,
                        color: ColorStyles.color_1a1a1a,
                      ),
                    ),
                  ],
                ),
                PetList(),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0, bottom: 10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        scrollToTop();
                      },
                      child: const Icon(Icons.keyboard_arrow_up),
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FabCircularMenu(
              alignment: Alignment.bottomCenter,
              ringColor: Colors.grey.withAlpha(50),
              ringDiameter: 450,
              ringWidth: 150.0,
              fabSize: 44.0,
              fabElevation: 10.0,
              fabIconBorder: CircleBorder(),
              fabOpenColor: Colors.grey,
              fabCloseColor: ColorStyles.main_color,
              fabColor: Colors.white,
              fabOpenIcon: Icon(Icons.add, color: ColorStyles.white),
              fabCloseIcon: Icon(Icons.close, color: ColorStyles.white),
              fabMargin: const EdgeInsets.all(5.0),
              animationDuration: const Duration(milliseconds: 800),
              animationCurve: Curves.bounceInOut,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: CreatePetScreen()));
                  },
                  icon: Icon(
                    Icons.pets,
                    size: 40,
                    color: ColorStyles.white,
                  ),
                  label: Text("Add pet"),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: MapScreen()));
                  },
                  icon: Icon(
                    Icons.book_outlined,
                    size: 40,
                    color: ColorStyles.white,
                  ),
                  label: Text("Book now"),
                ),
              ]));
    });
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
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
                future: getStoreDetail(id),
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
                      child: ListView(
                        children: [
                          Center(
                            child: CustomText(
                                text: "Store Detail",
                                size: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  //load image from network with error handler
                                  image: NetworkImageWithRetry(
                                      snapshot.data[0]["imageUrl"]),
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
                                  text: "Store Name:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["storeName"],
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
                                  text: "Location:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: snapshot.data[0]["location"],
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
                                  text: "Rate:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: snapshot.data[0]["rate"].toString(),
                                      size: 16,
                                      color: ColorStyles.black,
                                    ),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text: "Distance:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomText(
                                  text:
                                      snapshot.data[0]["distance"].toString() +
                                          " km",
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
                                  text:
                                      snapshot.data[0]["description"].length ==
                                              0
                                          ? "None"
                                          : snapshot.data[0]["description"],
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
                                  text: "Available services:",
                                  size: 16,
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder(
                            future: getServiceList(snapshot.data[0]["id"]),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot2.hasError) {
                                return Text(snapshot2.error.toString());
                              } else {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot2.data.length,
                                  itemBuilder: (_, index) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CustomText(
                                            text: "   " +
                                                snapshot2.data[index]["name"],
                                            size: 16,
                                            color: ColorStyles.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CustomText(
                                            text:
                                                " - ${currency.format((snapshot2.data[index]["price"]))} đ",
                                            size: 16,
                                            color: ColorStyles.black,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          FutureBuilder(
                              future: getUserDetail(uid),
                              builder: (context, snapshotUser) {
                                return (snapshotUser.data[0]["lastLocation"] !=
                                        "")
                                    ? (Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FloatingActionButton.extended(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: BookServiceScreen(
                                                        currentAddress:
                                                            snapshotUser.data[0]
                                                                [
                                                                "lastLocation"],
                                                        currentStore: snapshot
                                                            .data[0]["id"],
                                                        storeName: snapshot
                                                                .data[0]
                                                            ["storeName"])));
                                          },
                                          icon: Icon(
                                            Icons.book_outlined,
                                            size: 40,
                                            color: ColorStyles.white,
                                          ),
                                          label: Text("Book now"),
                                        ),
                                      ))
                                    : (Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FloatingActionButton.extended(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: MapScreen()));
                                          },
                                          icon: Icon(
                                            Icons.book_outlined,
                                            size: 40,
                                            color: ColorStyles.white,
                                          ),
                                          label: Text("Book now"),
                                        ),
                                      ));
                              }),
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
