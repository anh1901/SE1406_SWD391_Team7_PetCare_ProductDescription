import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';
import 'package:petcare/widgets/commons.dart';

Widget postLike(int index) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new GestureDetector(
            child: Container(
              width: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    size: 20,
                    color: ColorStyles.color_666666,
                  ),
                  SizedBox(width: 3),
                  Text(
                    "${snapshot.data.postList[index].noLike}",
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorStyles.color_666666,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              //
            },
          );
        } else if (snapshot.hasError) {
          return new CircularProgressIndicator();
        }
        return new CircularProgressIndicator();
      },
    );
