// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik_app/widgets/navbar.dart';
import 'package:leak_detector/leak_detector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    LeakDetector().init(maxRetainingPath: 300);
    LeakDetector().onLeakedStream.listen((LeakedInfo info) {
      //print to console
      info.retainingPath.forEach((node) => print(node));
      //show preview page
      // showLeakedInfoPage(navigatorKey.currentContext, info);
    });
    LeakDetector().onEventStream.listen((DetectorEvent event) {
      print(event);
      if (event.type == DetectorEventType.startAnalyze) {
        setState(() {
          _checking = true;
        });
      } else if (event.type == DetectorEventType.endAnalyze) {
        setState(() {
          _checking = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [
        LeakNavigatorObserver(
          shouldCheck: (route) =>
              route.settings.name != null && route.settings.name != "/",
        )
      ],
      title: "Komik",
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: "montserrat",
          scaffoldBackgroundColor: Color(0xff181920)),
      home: Navbar(),
    );
  }
}
