import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare/services/posts_service.dart';
import 'package:petcare/widgets/commons.dart';

import 'components/post_comment.dart';
import 'components/post_like.dart';
import 'components/post_share.dart';
import 'components/poster_avatar.dart';
import 'components/poster_location.dart';
import 'components/poster_media.dart';
import 'components/poster_message.dart';
import 'components/poster_nickname.dart';
import 'components/sneak_peak_comment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(
                      //
                      ),
                  PostList(snapshot.data.postList.length),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return new Text("${snapshot}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  Widget PostList(int number) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 2),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            avatar(index),
                            SizedBox(width: 8),
                            nickname(index),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        message(index),
                        media(index),
                        location(index),
                        SizedBox(height: 8),
                        Divider(color: ColorStyles.color_e8e8e8, height: 0.5),
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              postLike(index),
                              postComment(index),
                              postShare,
                            ],
                          ),
                        ),
                        sneakComment(index),
                      ],
                    ),
                  ),
                  Container(height: 10, color: ColorStyles.color_f7f7f7),
                ],
              ),
              onTap: () {
                //
              },
            );
          },
          childCount: number,
        ),
      ),
    );
  }
}
