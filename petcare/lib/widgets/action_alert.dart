import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_size.dart';
import 'commons.dart';

typedef VoidCallBack = void Function();

class ActionAlert {
  static showCenter(
    BuildContext context, {
    @required Widget child,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (ctx) {
        return GestureDetector(
          child: Container(
            color: Colors.black38,
            child: Center(child: child),
          ),
          onTap: () {
            if (barrierDismissible) {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }
          },
        );
      },
    );
  }

  static showAlert({
    @required BuildContext context,
    String title,
    String message,
    String leftTitle,
    String rightTitle,
    VoidCallBack leftPressed,
    VoidCallBack rightPressed,
  }) {
    if (SizeFit.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return _CupertinoAlert(
              context: context,
              title: title,
              message: message,
              leftTitle: leftTitle,
              rightTitle: rightTitle,
              leftPressed: leftPressed,
              rightPressed: rightPressed,
            );
          });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return _MaterialAlert(
              context: context,
              title: title,
              message: message,
              leftTitle: leftTitle,
              rightTitle: rightTitle,
              leftPressed: leftPressed,
              rightPressed: rightPressed,
            );
          });
    }
  }

  static Future<Null> showCommitOptionDialog(
      {@required BuildContext context,
      List<Color> colorList,
      double width = 250.0,
      bool isNight = false,
      List<String> titleList,
      ValueChanged<int> onTap}) {
    final titleArray = titleList ?? [];
    final colorArray = colorList ?? [];
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: width,
              height: titleArray.length * 44.0 + 8,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ColorStyles.whiteColor(isNight),
                  borderRadius: BorderRadius.circular(4)),
              child: ListView.builder(
                itemCount: titleArray.length,
                itemBuilder: (context, index) {
                  final backColor = colorArray.length > 0
                      ? colorArray[index]
                      : (isNight
                          ? ColorStyles.color_151b26
                          : ColorStyles.white);
                  final textColor = (colorArray.length > 0 || isNight)
                      ? ColorStyles.white
                      : ColorStyles.color_1a1a1a;
                  return ElevatedButton(
                    child: Text(titleArray[index],
                        style: TextStyle(fontSize: 14, color: textColor)),
                    onPressed: () {
                      onTap(index);
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  static Future<T> showTKDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: SafeArea(child: builder(context)));
        });
  }
}

class _CupertinoAlert extends StatelessWidget {
  final String title;
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallBack leftPressed;
  final VoidCallBack rightPressed;

  _CupertinoAlert(
      {@required BuildContext context,
      this.title = '',
      this.message = '',
      this.leftTitle = 'data',
      this.rightTitle = 'data',
      this.leftPressed,
      this.rightPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? '',
          style: TextStyle(
              fontSize: 17,
              color: ColorStyles.color_1a1a1a,
              fontWeight: FontWeight.bold)),
      content: Container(
        padding: EdgeInsets.only(top: 8),
        child: Text(message ?? '',
            style: TextStyle(
              fontSize: 16,
              color: ColorStyles.color_333333,
              fontWeight: FontWeight.bold,
            )),
      ),
      actions: renderActions(context),
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> itemList = [];

    Widget leftItem = CupertinoDialogAction(
      textStyle: TextStyle(fontSize: 16, color: ColorStyles.color_999999),
      child: Text(leftTitle ?? 'data'),
      onPressed: () {
        Navigator.of(context).pop();
        if (leftPressed != null) {
          leftPressed();
        }
      },
    );
    itemList.add(leftItem);

    if (rightTitle != null) {
      Widget item = CupertinoDialogAction(
        textStyle: TextStyle(fontSize: 16, color: ColorStyles.main_color),
        child: Text(rightTitle),
        onPressed: () {
          Navigator.of(context).pop();
          if (rightPressed != null) {
            rightPressed();
          }
        },
      );
      itemList.add(item);
    }

    return itemList;
  }
}

class _MaterialAlert extends StatelessWidget {
  final String title;
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallBack leftPressed;
  final VoidCallBack rightPressed;

  _MaterialAlert(
      {@required BuildContext context,
      this.title = '',
      this.message = '',
      this.leftTitle = 'Cancel',
      this.rightTitle = 'Ok',
      this.leftPressed,
      this.rightPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ''),
      titleTextStyle: TextStyle(
          fontSize: 17,
          color: ColorStyles.color_1a1a1a,
          fontWeight: FontWeight.bold),
      // titlePadding: EdgeInsets.only(top: 8.px),
      content: Text(message ?? ''),
      contentTextStyle:
          TextStyle(fontSize: 15, color: ColorStyles.color_333333),
      // contentPadding: EdgeInsets.only(top: 8.px),
      actions: renderActions(context),
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> itemList = [];

    Widget leftItem = FlatButton(
      child: Text(leftTitle ?? 'Cancel',
          style: TextStyle(fontSize: 16, color: ColorStyles.color_999999)),
      onPressed: () {
        Navigator.of(context).pop();
        if (leftPressed != null) {
          leftPressed();
        }
      },
    );
    itemList.add(leftItem);

    if (rightTitle != null) {
      Widget item = FlatButton(
        child: Text(rightTitle,
            style: TextStyle(fontSize: 16, color: ColorStyles.main_color)),
        onPressed: () {
          Navigator.of(context).pop();
          if (leftPressed != null) {
            rightPressed();
          }
        },
      );
      itemList.add(item);
    }

    return itemList;
  }
}
