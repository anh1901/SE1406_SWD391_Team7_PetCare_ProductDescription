import 'package:flutter/material.dart';
import 'package:petcare/screens/basic_screen/basic_screen.dart';
import 'package:petcare/screens/login_screen/login_screen.dart';
import 'package:petcare/screens/login_screen/signup_screen.dart';
import 'package:petcare/screens/splash_screen/splash_screen.dart';
import 'package:petcare/screens/welcome_screen/welcome_screen.dart';

class RouteUtil {
  static final String welcomeRoute = WelcomeScreen.routerName;
  static final String splashRoute = SplashScreen.routerName;
  static final Map<String, WidgetBuilder> routeList = {
    WelcomeScreen.routerName: (ctx) => WelcomeScreen(),
    SplashScreen.routerName: (ctx) => SplashScreen(),
    LoginScreen.routerName: (ctx) => LoginScreen(),
    BasicScreen.routerName: (ctx) => BasicScreen(),
    SignUpScreen.routerName: (ctx) => SignUpScreen(),
  };

  static final RouteFactory generateRoute = (setting) {
    return null;
  };
  static final RouteFactory unknownRoute = (setting) {
    return null;
  };
  static pushImagePreview(BuildContext context, Widget pageRoute) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (ctx, animal1, animal2) {
          return FadeTransition(opacity: animal1, child: pageRoute);
        },
      ),
    );
  }

  static push(BuildContext context, Widget pageRoute,
      {RouteSettings settings}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => pageRoute, settings: settings));
  }

  static pushMainRoot(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(SplashScreen.routerName);
  }

  static popRoot(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  static popToRoutePage(BuildContext context) {
    final routeName = ModalRoute.of(context).settings.arguments;
    if (routeName == '/') {
      popRoot(context);
    } else {
      Navigator.of(context).popUntil(routeName);
    }
  }
}
