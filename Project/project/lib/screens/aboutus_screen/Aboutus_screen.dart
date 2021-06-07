import 'package:flutter/material.dart';
import 'package:project/widgets/commons.dart';
import 'package:project/widgets/custom_text.dart';

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
      body: Center(
        child: Text(
          'This is an about us screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
