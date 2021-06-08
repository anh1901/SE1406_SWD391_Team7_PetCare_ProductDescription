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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomText(
                        text: "Looking for something for your pet?",
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );
    });
  }
}
