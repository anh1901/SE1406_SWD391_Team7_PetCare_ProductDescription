import 'package:flutter/material.dart';
import 'package:petcare/widgets/commons.dart';

final List<Widget> title = [
  Padding(
    padding: const EdgeInsets.only(left: 45.0, top: 0.0),
    child: Row(
      children: [
        Text(
          "PET",
          style: TextStyle(
              fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Text(
          "CARE",
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue[200],
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  ),
  Row(
    children: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.message_outlined,
            ),
            onPressed: () {},
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: ColorStyles.color_05cb98,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    ],
  )
];
