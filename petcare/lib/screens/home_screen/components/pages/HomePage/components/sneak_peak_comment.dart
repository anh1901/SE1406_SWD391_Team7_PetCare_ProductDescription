import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:sizer/sizer.dart';

Widget sneakComment(int index) => FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Sizer(
            builder: (context, orientation, deviceType) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: ColorStyles.color_f7f7f7,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(children: <InlineSpan>[
                          WidgetSpan(
                            child: Text(
                                '${snapshot.data.postList[index].commentList[0].nickname}' +
                                    ': ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: ColorStyles.color_526e94)),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          WidgetSpan(
                              child: Text(
                                  "${snapshot.data.postList[index].commentList[0].commentInfo}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: ColorStyles.color_666666)),
                              alignment: PlaceholderAlignment.middle)
                        ]),
                        softWrap: true,
                      ),
                      SizedBox(height: 3),
                      Text.rich(
                        TextSpan(children: <InlineSpan>[
                          WidgetSpan(
                            child: Text(
                              'View more comment',
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorStyles.color_526e94,
                              ),
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 20,
                              color: ColorStyles.main_color,
                            ),
                            alignment: PlaceholderAlignment.middle,
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return new CircularProgressIndicator();
        }
        return new CircularProgressIndicator();
      },
    );
