import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:petcare/redux/redux_index.dart';
import 'package:petcare/widgets/commons.dart';

import 'basic_screen/components/items_list.dart';

class MainScreen extends StatefulWidget {
  static final String routerName = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(
      builder: (context, store) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: store.state.isNightModal
                ? ColorStyles.white
                : store.state.themeData.primaryColor,
            backgroundColor: ColorStyles.whiteColor(store.state.isNightModal),
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            unselectedItemColor:
                ColorStyles.grayColor(store.state.isNightModal),
            selectedIconTheme: IconThemeData(
                size: 24,
                color: store.state.isNightModal
                    ? ColorStyles.white
                    : store.state.themeData.primaryColor),
            unselectedIconTheme: IconThemeData(
                size: 24,
                color: ColorStyles.grayColor(store.state.isNightModal)),
            currentIndex: currentIndex,
            onTap: (value) {
              currentIndex = value;
              _pageController.animateToPage(
                value,
                duration: Duration(milliseconds: 200),
                curve: Curves.linear,
              );
              setState(() {});
            },
            items: itemList(store, context),
          ),
          body: DoubleBackToCloseApp(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  currentIndex = page;
                });
              },
              children: pageList,
            ),
            snackBar: SnackBar(
              content: SizedBox(
                  child: Text("${AppLocalizations.of(context).doubleTap}")),
              backgroundColor: Colors.black26,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 70, left: 10.0, right: 10.0),
            ),
          ),
        );
      },
    );
  }
}
