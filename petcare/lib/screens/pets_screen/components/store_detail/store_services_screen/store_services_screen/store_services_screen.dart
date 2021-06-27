import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/models/store_model.dart';
import 'package:petcare/screens/pets_screen/components/store_detail/store_services_screen/store_services_screen/service_item.dart';
import 'package:petcare/widgets/custom_text.dart';

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

class StoreServiceScreen extends StatefulWidget {
  const StoreServiceScreen({Key key, @required this.id}) : super(key: key);
  final String id;
  @override
  _StoreServiceScreen createState() => _StoreServiceScreen();
}

class _StoreServiceScreen extends State<StoreServiceScreen> {
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
              Text('Available services',
                  style: Theme.of(context).textTheme.headline4),
              AnimatedContainer(
                width: 200.0,
                height: 400.0,
                alignment: Alignment.topLeft,
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: FutureBuilder(
                    future: getServiceList(widget.id),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot2.hasError) {
                        return Text(snapshot2.error.toString());
                      } else {
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 400),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot2.data.length,
                            itemBuilder: (_, index) => ServiceItem(
                              storeId: snapshot2.data[index]["id"],
                              name: snapshot2.data[index]["name"],
                              price: snapshot2.data[index]["price"],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          );
        }
      },
    );
  }
}
