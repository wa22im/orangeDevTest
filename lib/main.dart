import 'package:flutter/material.dart';
import 'package:orangeTest/models/voiture.dart';
import 'package:orangeTest/screens/home_screen/homeScreen.dart';
import 'package:orangeTest/screens/voiture_detail_screen/voiture_detail_screen.dart';
import 'package:orangeTest/widgets/googlemap/googleMap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
