import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:petcare/redux/redux_state.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';

import 'components/shopping_screen_title.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key key}) : super(key: key);

  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(builder: (context, store) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: title,
              ),
              SizedBox(
                  height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                      children: [
                        Image.asset(
                          'assets/images/avatar.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ]
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: "Pet toys",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                      CustomText(
                        text: "Price: 30.0",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('View Detail'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('Add to cart'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                      children: [
                        Image.asset(
                          'assets/images/avatar.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ]
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: "Pet toys",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                      CustomText(
                        text: "Price: 30.0",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('View Detail'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('Add to cart'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                      children: [
                        Image.asset(
                          'assets/images/avatar.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ]
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: "Pet toys",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                      CustomText(
                        text: "Price: 30.0",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('View Detail'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('Add to cart'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                      children: [
                        Image.asset(
                          'assets/images/avatar.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ]
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: "Pet toys",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                      CustomText(
                        text: "Price: 30.0",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('View Detail'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: (){},
                            color: Colors.grey[400],
                            child: Text('Add to cart'),
                            height: 30.0,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      );
    });
  }
}
