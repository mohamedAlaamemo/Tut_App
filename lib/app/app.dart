import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mina_farid/presentation/resources/routes_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  //named constructor
  const MyApp._internal();

  // single instance or singleton
  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
