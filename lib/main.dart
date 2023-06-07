import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oneHour/Screens/homepage.dart';
import 'package:oneHour/bottom_nav.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final navigatorKey = GlobalKey<NavigatorState>();
  initializeDateFormatting();
  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(
      navigatorKey: navigatorKey,
    ));
  });
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Hour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomNavBar(),
    );
  }
}

