import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare/widgets/commons.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: ,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(
                      //
                      ),
                  ListStores(snapshot.data.postList.length),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return new Text("${snapshot}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  Widget ListStores(int number) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 2),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              child: Column(
                children: <Widget>[
                  Container(height: 10, color: ColorStyles.color_f7f7f7),
                ],
              ),
              onTap: () {
                //
              },
            );
          },
          childCount: number,
        ),
      ),
    );
  }
}
