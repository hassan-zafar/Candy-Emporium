import 'package:candy_emporium/config/palette.dart';
import 'package:candy_emporium/productScreens/kannapyStore.dart';
import 'package:candy_emporium/screens/auth/auth.dart';
import 'package:candy_emporium/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:candy_emporium/screens/splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // LitAuthInit(
        //   authProviders: AuthProviders(google: true, apple: true),
        //   child:
        GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Candy Emporium', builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Palette.darkOrange,
        primaryColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        textTheme: TextTheme(headline1: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          brightness: Brightness.dark,
          color: Palette.darkBlue,
        ),
      ),
      home: AuthScreen(),
      // ),
    );
  }
}
