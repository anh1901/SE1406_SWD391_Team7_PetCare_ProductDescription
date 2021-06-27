import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare/models/store_model.dart';
import 'package:petcare/screens/pets_screen/components/store_detail/store_info_screen/store_info_screen.dart';
import 'package:petcare/screens/pets_screen/components/store_detail/store_review/store_review_screen.dart';
import 'package:petcare/screens/pets_screen/components/store_detail/store_services_screen/store_services_screen/store_services_screen.dart';

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

class StoreDetailPage extends StatefulWidget {
  final String id;
  const StoreDetailPage(this.id, {Key key}) : super(key: key);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: <Widget>[
          StoreBodyBackground(id: widget.id),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 0,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 32,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: Colors.transparent,
              body: StoreBody(id: widget.id),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreBodyBackground extends StatelessWidget {
  const StoreBodyBackground({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getStoreDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .60,
              child: Hero(
                tag: Key('key' + snapshot.data[0]["imageUrl"]),
                child: Container(
                  height: MediaQuery.of(context).size.height * .25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(snapshot.data[0]["imageUrl"]),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(0, .8),
                            end: Alignment(0, 0),
                            colors: [
                          Color(0xEE000000),
                          Color(0x33000000),
                        ])),
                  ),
                ),
              ),
            );
          }
        });
  }
}

class StoreBody extends StatelessWidget {
  final String id;

  const StoreBody({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 60, top: 144),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 8),
          Expanded(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              elevation: 8,
              child: Container(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TabBarView(
                            children: [
                              StoreInfoScreen(id: id),
                              StoreServiceScreen(id: id),
                              StoreReviewScreen(id: id),
                            ],
                          ),
                        ),
                      ),
                      TabBar(
                        indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(color: Color(0xDD613896), width: 4.0),
                          insets: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'Info',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Services',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Reviews',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
