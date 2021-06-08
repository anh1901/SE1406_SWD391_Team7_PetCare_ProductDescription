import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/screens/basic_screen/basic_screen.dart';
import 'package:petcare/screens/login_screen/login_screen.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/size_config.dart';
import 'package:provider/provider.dart';

import 'components/splash_body.dart';

class SplashScreen extends StatefulWidget {
  static final String routerName = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    print("User $firebaseUser");
    Timer(
      Duration(seconds: 4),
      () => {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                firebaseUser != null ? BasicScreen() : LoginScreen(),
          ),
        ),
      },
    );

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: SplashBody(),
    );
  }
}
