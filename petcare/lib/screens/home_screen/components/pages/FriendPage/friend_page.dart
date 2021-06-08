import 'package:flutter/material.dart';
import 'package:petcare/widgets/custom_text.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(
              text: "Friend Page",
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
