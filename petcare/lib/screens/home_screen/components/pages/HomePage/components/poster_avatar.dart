import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';

Widget avatar(int number) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new GestureDetector(
            child: SizedBox(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      "${snapshot.data.postList[number].userInfo.avatarImg}"),
                ),
              ),
              width: 45,
              height: 45,
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
