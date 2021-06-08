import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:petcare/caches/shared_storage.dart';
import 'package:petcare/redux/redux_index.dart';
import 'package:petcare/utils/function_util.dart';
import 'package:petcare/utils/route_util.dart';
import 'package:redux/redux.dart';

class ReduxApp extends StatefulWidget {
  @override
  _ReduxAppState createState() => _ReduxAppState();
}

class _ReduxAppState extends State<ReduxApp> with NavigatorObserver {
  final store = Store<ReduxState>(
    appReducer,
    initialState: ReduxState(
      themeData: FunctionUtils.getThemeData(0),
      locale: Locale('en', 'EN'),
      isNightModal: false,
    ),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      navigator.context;
      navigator;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWelcome = SharedStorage.showWelcome;
    return StoreProvider(
      store: store,
      child: StoreBuilder<ReduxState>(
        builder: (context, store) {
          store.state.platformLocale = WidgetsBinding.instance.window.locale;
          Map<String, WidgetBuilder> routes = RouteUtil.routeList;
          // routes.addAll(routeList);
          return MaterialApp(
            title: 'Pet Care-Let your pet the best.',
            theme: store.state.themeData,
            supportedLocales: [store.state.locale],
            locale: store.state.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            initialRoute:
                isWelcome ? RouteUtil.splashRoute : RouteUtil.welcomeRoute,
            onUnknownRoute: RouteUtil.unknownRoute,
            routes: routes,
            debugShowCheckedModeBanner: false,
            navigatorObservers: [this],
            builder: (ctx, child) {
              return FlutterEasyLoading(child: child);
            },
          );
        },
      ),
    );
  }
}
