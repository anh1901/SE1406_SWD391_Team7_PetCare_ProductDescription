import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:petcare/screens/home_screen/home_screen.dart';
import 'package:petcare/screens/notifications_screen/notification_screen.dart';
import 'package:petcare/screens/pets_screen/pets_screen.dart';
import 'package:petcare/screens/profile_screen/profile_screen.dart';
import 'package:petcare/screens/shopping_screen/shopping_screen.dart';
import 'package:redux/redux.dart';

final List<Widget> pageList = [
  PetsScreen(),
  HomeScreen(),
  ShoppingScreen(),
  NotificationsScreen(),
  ProfileScreen(),
];
List<BottomNavigationBarItem> itemList(Store store, BuildContext context) {
  return [
    BottomNavigationBarItem(
      icon: Icon(Icons.pets),
      label: AppLocalizations.of(context).petsScreen,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: AppLocalizations.of(context).home,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: AppLocalizations.of(context).shopping,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: AppLocalizations.of(context).events,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_identity),
      label: AppLocalizations.of(context).profileScreen,
    ),
  ];
}
