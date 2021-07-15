import 'package:flutter/material.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'About us',
          color: ColorStyles.black,
          fontWeight: FontWeight.bold,
          size: 20,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(
            'This app is made by 3 inexperience students who just know coding flutter.\nIf there are any error, please tell us.',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
