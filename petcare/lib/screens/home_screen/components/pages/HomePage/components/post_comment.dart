import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';
import 'package:petcare/widgets/commons.dart';

Widget postComment(int index) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
            width: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.message,
                  size: 20,
                  color: ColorStyles.color_666666,
                ),
                SizedBox(width: 3),
                Text(
                  '${snapshot.data.postList[index].noComment}',
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorStyles.color_666666,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return new CircularProgressIndicator();
        }
        return new CircularProgressIndicator();
      },
    );
