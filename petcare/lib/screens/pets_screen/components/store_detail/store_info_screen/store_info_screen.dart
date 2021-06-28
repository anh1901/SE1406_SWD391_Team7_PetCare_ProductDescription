import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/models/store_model.dart';
import 'package:petcare/models/user.dart';
import 'package:petcare/screens/pets_screen/components/add_appointment/book_service_screen.dart';
import 'package:petcare/screens/pets_screen/components/add_appointment/map_screen.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;
Future getUserDetail(String id) async {
  QuerySnapshot userDetail = (await userRef(id).get());
  return userDetail.docs;
}

final userRef = (String id) => FirebaseFirestore.instance
    .collection('users')
    .where("uid", isEqualTo: id)
    .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()),
      toFirestore: (user, _) => user.toJson(),
    );

final currency = new NumberFormat("#,##0", "vi_VN");
final storeDetailRef = (String id) => FirebaseFirestore.instance
    .collection('stores')
    .where("id", isEqualTo: id)
    .withConverter<StoreModel>(
      fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()),
      toFirestore: (store, _) => store.toJson(),
    );
Future getStoreDetail(String id) async {
  QuerySnapshot storeList = (await storeDetailRef(id).get());
  return storeList.docs;
}

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

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({Key key, @required this.id}) : super(key: key);
  final String id;
  @override
  _StoreInfoScreenState createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStoreDetail(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Text(
                          'POPULAR',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: snapshot.data[0]["rate"].toString(),
                          size: 16,
                          color: Colors.black,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                snapshot.data[0]["storeName"],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 14),
              AnimatedContainer(
                width: 200.0,
                height: selected ? 250.0 : 100.0,
                alignment: selected
                    ? Alignment.center
                    : AlignmentDirectional.topCenter,
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: ListView(
                  children: [
                    Text(snapshot.data[0]["description"]),
                    Divider(),
                    Container(
                      child: Row(
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
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CustomText(
                                text: snapshot.data[0]["location"],
                                size: 16,
                                color: ColorStyles.black,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                              double.parse(snapshot.data[0]["rate"]) >= 4
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.green,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8),
                                          child: Text(
                                            'Positive',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.blue,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8),
                                          child: Text(
                                            'Average',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                snapshot.data[0]["distance"].toString() + " km",
                            size: 16,
                            color: ColorStyles.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                child: !selected
                    ? Text(
                        'More info',
                        style: TextStyle(color: Colors.lightBlueAccent),
                      )
                    : Text(
                        'Less info',
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ),
              ),
              FutureBuilder(
                  future: getUserDetail(uid),
                  builder: (context, snapshotUser) {
                    return (snapshotUser.data[0]["lastLocation"] != "")
                        ? (Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: BookServiceScreen(
                                            currentAddress: snapshotUser.data[0]
                                                ["lastLocation"],
                                            currentStore: snapshot.data[0]
                                                ["id"],
                                            storeName: snapshot.data[0]
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
                          ));
                  }),
            ],
          );
        }
      },
    );
  }
}
