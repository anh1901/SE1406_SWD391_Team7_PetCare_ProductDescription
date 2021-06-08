import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';
import 'package:petcare/widgets/size_config.dart';

Widget media(int index) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
            padding: EdgeInsets.only(top: 8),
            child: SizedBox(
              child: Image.network(
                  '${snapshot.data.postList[index].fileList[0].fileUrl}'),
              width: SizeConfig.screenWidth,
              height: 400,
            ),
          );
        } else if (snapshot.hasError) {
          return new CircularProgressIndicator();
        }
        return new CircularProgressIndicator();
      },
    );
