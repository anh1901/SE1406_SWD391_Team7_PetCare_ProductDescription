import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';
import 'package:petcare/widgets/commons.dart';

Widget location(int index) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on,
                    size: 16, color: ColorStyles.color_666666),
                SizedBox(width: 4),
                Text('${snapshot.data.postList[index].location}',
                    style: TextStyle(
                        fontSize: 13, color: ColorStyles.color_6f6f6f))
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return new CircularProgressIndicator();
        }
        return new CircularProgressIndicator();
      },
    );
