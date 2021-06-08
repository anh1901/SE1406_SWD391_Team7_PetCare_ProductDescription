import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:petcare/redux/redux_index.dart';
import 'package:petcare/screens/home_screen/components/pages/FriendPage/friend_page.dart';
import 'package:petcare/screens/home_screen/components/pages/HomePage/home_page.dart';
import 'package:petcare/screens/home_screen/components/pages/RecommendedPage/recommend_page.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/size_config.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ["home_page", "friend_page", "recommended_page"];
  List<Widget> tabViews = [HomePage(), FriendPage(), RecommendedPage()];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(
      builder: (context, store) {
        tabs = [
          AppLocalizations.of(context).home_page,
          AppLocalizations.of(context).friend_page,
          AppLocalizations.of(context).recommend_page
        ];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                  top: Radius.circular(30),
                ),
              ),
              toolbarHeight: SizeConfig.screenHeight / 20,
              backgroundColor: Colors.white,
              title: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: ColorStyles.black,
                indicatorWeight: 5,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: ColorStyles.blackColor(store.state.isNightModal),
                unselectedLabelColor:
                    ColorStyles.grayColor(store.state.isNightModal),
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                labelPadding: EdgeInsets.symmetric(horizontal: 15),
                tabs: tabs
                    .map(
                      (e) => Tab(
                        child: SizedBox(
                          width: SizeConfig.screenWidth / 4,
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(e),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: tabViews.map((e) => e).toList(),
            ),
          ),
        );
      },
    );
  }
}
