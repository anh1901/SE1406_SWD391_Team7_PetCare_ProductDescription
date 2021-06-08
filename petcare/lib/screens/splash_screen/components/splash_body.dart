import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petcare/services/facts_service.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/dafault_image.dart';

class SplashBody extends StatelessWidget {
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DefaultImage(
                      image: 'assets/images/pet_care_logo.png',
                      width: 200,
                      height: 80,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    CustomText(
                      text: 'Get your pet the best care',
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    FutureBuilder(
                      future: loadFact(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return new Container(
                              padding: new EdgeInsets.all(5.0),
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(25.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    child: CustomText(
                                      text:
                                          "Fact: ${snapshot.data.factList[next(0, snapshot.data.factList.length)].fact}",
                                      size: 14,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ));
                        } else if (snapshot.hasError) {
                          return new Text("${snapshot}");
                        }
                        return new CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
