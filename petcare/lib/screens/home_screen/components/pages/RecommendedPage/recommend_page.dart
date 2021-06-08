import 'package:flutter/material.dart';
import 'package:petcare/widgets/custom_text.dart';

class RecommendedPage extends StatefulWidget {
  @override
  _RecommendedPageState createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(
              text: "Recommended Page",
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
