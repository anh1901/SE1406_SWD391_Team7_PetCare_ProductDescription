import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:petcare/caches/shared_constant.dart';
import 'package:petcare/caches/shared_util.dart';
import 'package:petcare/main.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/redux/redux_state.dart';
import 'package:petcare/services/authentication_service.dart';
import 'package:petcare/utils/function_util.dart';
import 'package:petcare/utils/route_util.dart';
import 'package:petcare/widgets/action_alert.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

import 'components/detail_page.dart';

class ProfileScreen extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(
      builder: (context, store) {
        final isLogin = store.state.isLogin ?? false;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(AppLocalizations.of(context).profile),
            centerTitle: true,
          ),
          body: Container(
            color: ColorStyles.marginColor(store.state.isNightModal),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: () {
                if (!isLogin) {
                  _refreshController.refreshCompleted();
                  return;
                }
              },
              child: CustomScrollView(
                slivers: [
                  renderHeaderItem(store, context),
                  renderAnimalTitle(store),
                  renderAnimalList(store),
                  renderProfileList(context, store)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget renderHeaderItem(Store store, BuildContext context) {
    bool isLogin = store.state.isLogin ?? false;
    String headerImg = '';
    String nickName = 'Anhwtuan';
    String userIntro = 'Dog lover';
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: 1000,
            height: SizeFit.screenHeight / 6,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  store.state.themeData.primaryColor, BlendMode.srcOver),
              child: Image.asset(
                'assets/images/pet_care_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/dog-bone.png"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nickName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorStyles.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: isLogin ? 3 : 0),
                              isLogin
                                  ? Text(userIntro,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: ColorStyles.white,
                                      ))
                                  : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right,
                      size: 30, color: ColorStyles.white)
                ],
              ),
            ),
            onTap: () {
              if (isLogin) {
                RouteUtil.push(context, DetailPage());
              } else {
                // FunctionUtils.jumpLogin(context);
                RouteUtil.push(context, DetailPage());
              }
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimalTitle(Store store) {
    List<PetModel> petList = store.state.petList ?? [];
    if (petList.length == 0) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverToBoxAdapter(
      child: Container(
        width: SizeFit.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My pet',
                style: TextStyle(
                    fontSize: 15,
                    color: ColorStyles.blackColor(store.state.isNightModal))),
            GestureDetector(
              child: Row(
                children: [
                  Text('Tất cả',
                      style: TextStyle(
                          fontSize: 14,
                          color:
                              ColorStyles.grayColor(store.state.isNightModal))),
                  Icon(Icons.keyboard_arrow_right,
                      color: ColorStyles.grayColor(store.state.isNightModal),
                      size: 18)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderAnimalList(Store store) {
    List<PetModel> petList = store.state.petList ?? [];
    if (petList.length == 0) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(right: 15),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: petList.map((e) {
            return renderAnimalItem(store, e);
          }).toList(),
        ),
      ),
    );
  }

  Widget renderAnimalItem(Store store, PetModel petModel) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 16, bottom: 8),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ColorStyles.whiteColor(store.state.isNightModal),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Image.asset('assets/images/dog-bone.png'),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(petModel.petName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorStyles.blackColor(store.state.isNightModal),
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 3),
                Text(petModel.birthday ?? '',
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            ColorStyles.grayColor(store.state.isNightModal))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget renderProfileList(BuildContext context, Store store) {
    final titles = [
      AppLocalizations.of(context).changeTheme,
      AppLocalizations.of(context).language,
      AppLocalizations.of(context).editProfile,
      AppLocalizations.of(context).order,
      AppLocalizations.of(context).shippingAddress,
      AppLocalizations.of(context).creditCard,
      AppLocalizations.of(context).reviewMyApp,
      AppLocalizations.of(context).aboutus,
      AppLocalizations.of(context).logout,
    ];
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: ColorStyles.whiteColor(store.state.isNightModal),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: titles.map((e) {
            final index = titles.indexOf(e);
            final isLast = index == titles.length - 1;
            return GestureDetector(
              child: Container(
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color:
                                ColorStyles.lineColor(store.state.isNightModal),
                            width: isLast ? 0.001 : 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e,
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorStyles.blackColor(
                                store.state.isNightModal))),
                    Icon(Icons.keyboard_arrow_right,
                        color: ColorStyles.lineColor(store.state.isNightModal),
                        size: 18),
                  ],
                ),
              ),
              onTap: () {
                if (index == 0) {
                  //
                }
                if (index == 1) {
                  showLocalDialog(context, store);
                }
                if (index == 2) {
                  //
                }
                if (index == 3) {
                  //
                }
                if (index == 4) {
                  //
                }
                if (index == 4) {
                  //
                }
                if (index == 6) {
                  //
                }
                if (index == 7) {
                  //
                }
                if (index == 8) {
                  showLogoutDialog(context, store);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void showLocalDialog(BuildContext context, Store store) {
    final titles = ['Vietnamese', 'English'];
    ActionAlert.showCommitOptionDialog(
        context: context,
        titleList: titles,
        isNight: store.state.isNightModal,
        onTap: (index) {
          FunctionUtils.changeLocale(store, index);
          SharedUtils.setInt(SharedConstant.localIndex, index);
        });
  }

  void showLogoutDialog(BuildContext context, Store store) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('AlertDialog');
      },
    );
    Widget logoutButton = FlatButton(
      child: Text("Logout"),
      onPressed: () {
        // FunctionUtils.logOutAction(context);
        Navigator.of(context, rootNavigator: true).pop('AlertDialog');
        context.read<AuthenticationService>().signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to logout"),
      content: Text(
          "Click logout if you want to logout. You will be redirected to login screen."),
      actions: [cancelButton, logoutButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
