import 'package:flutter/material.dart';

final List<Widget> title = [
  Padding(
    padding: const EdgeInsets.only(left: 45.0, top: 10.0),
    child: Row(
      children: [
        Text(
          "Shop",
          style: TextStyle(
              fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Text(
          "ping",
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue[200],
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  ),
];
