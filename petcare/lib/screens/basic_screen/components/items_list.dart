import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
List<BottomNavigationBarItem> itemList(Store store) {
  return [
    BottomNavigationBarItem(
      icon: Icon(Icons.pets),
      label: "Pets",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Network",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Shopping",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: "Events",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_identity),
      label: "Profile",
    ),
  ];
}
