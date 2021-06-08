import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../aboutus_screen/Aboutus_screen.dart';
import '../main_screen.dart';

class BasicScreen extends StatelessWidget {
  static final String routerName = '/';
  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
      homePageXValue: 150,
      homePageYValue: 80,
      homePageAngle: -0.15,
      homePageSpeed: 250,
      shadowXValue: 122,
      shadowYValue: 110,
      shadowAngle: -0.275,
      shadowSpeed: 550,
      openIcon: Icon(
        Icons.menu_open,
        color: Color(0xFF1f186f),
      ),
      closeIcon: Icon(Icons.arrow_back_ios, color: Color(0xFF1f186f)),
      shadowColor: Color(0xff6c5fbf),
      backgroundGradient: LinearGradient(
        colors: [Color(0xff414fd5), Color(0xff463abb)],
      ),
      menuPageContent: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/pet_care_logo_128.png',
                width: 80,
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Row(
                children: [
                  Text(
                    "PET",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "CARE",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.blue[200],
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
              ),
              Text(
                AppLocalizations.of(context).settings,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Divider(
                color: Color(0xFF5950a0),
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context).about,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      homePageContent: MainScreen(),
    );
  }
}
