import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petcare/redux_app.dart';
import 'package:petcare/services/authentication_service.dart';
import 'package:petcare/utils/orientation_util.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/toast.dart';
import 'package:provider/provider.dart';

import 'caches/shared_storage.dart';
import 'config/device_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedStorage.initStorage().then((value) {
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
    Toast.setToastStyle();
  });
}

class MyApp extends StatelessWidget with PortraitModeMixin {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeFit.initialize();
    DeviceInfo.initialezed();
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("${snapshot.error.toString()}");
          } else if (snapshot.hasData) {
            return ReduxApp();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return null;
        },
      ),
    );
  }
}
