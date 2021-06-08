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
      body: Center(
        child: Text(
          'lorem ipsum dolor sit amet lorem ipsum dolor',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
