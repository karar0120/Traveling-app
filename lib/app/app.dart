import 'package:flutter/material.dart';

import '../presentation/resources/routes_manger.dart';
import '../presentation/resources/theme_manger.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  static final _instance = MyApp._internal();

  factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
    );
  }
}
