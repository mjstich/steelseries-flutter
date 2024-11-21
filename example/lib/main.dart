import 'package:flutter/material.dart';

import 'package:example/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steel Series Gauges Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      ),
      initialRoute: '/',
      routes: getRoutes(context),
    );
  }
}
