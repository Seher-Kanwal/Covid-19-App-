import 'package:covid_app/screens/splach_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Covid19 App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
