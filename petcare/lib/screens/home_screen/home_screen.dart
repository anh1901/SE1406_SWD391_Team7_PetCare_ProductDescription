import 'package:flutter/material.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

import 'components/home_title.dart';
import 'components/posts_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: title,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProfileScreen()),
                    //   );
                    // },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/images/avatar.png"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Color.fromRGBO(121, 181, 206, 1.0))),
                      onPressed: () {},
                      padding: EdgeInsets.all(5.0),
                      color: Colors.white,
                      textColor: Color.fromRGBO(91, 106, 220, 1.0),
                      child: CustomText(
                        text: "Lets share some thing...",
                        size: 18,
                        color: ColorStyles.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeFit.screenHeight * 0.8,
              child: PostScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
