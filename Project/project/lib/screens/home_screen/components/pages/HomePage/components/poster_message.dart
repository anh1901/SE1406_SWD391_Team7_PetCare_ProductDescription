import 'package:flutter/material.dart';
import 'package:project/services/posts_service.dart';
import 'package:project/widgets/commons.dart';

Widget message(int index) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Text(
            "${snapshot.data.postList[index].messageInfo}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: ColorStyles.color_333333),
          );
        } else if (snapshot.hasError) {
          return new CircularProgressIndicator();
        }
        return new CircularProgressIndicator();
      },
    );
