import 'package:flutter/material.dart';
import 'package:petcare/widgets/commons.dart';

final Widget postShare = Container(
  width: 70,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.share,
        size: 20,
        color: ColorStyles.color_666666,
      ),
      SizedBox(width: 3),
      Text(
        '',
        style: TextStyle(
          fontSize: 13,
          color: ColorStyles.color_666666,
        ),
      ),
    ],
  ),
);
