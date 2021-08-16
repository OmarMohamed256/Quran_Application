import 'package:flutter/material.dart';
import 'package:quran_application/QuranScreen.dart';
import 'package:quran_application/RadioSceen.dart';
import 'package:quran_application/SideMenu.dart';
import 'package:quran_application/TasbeehScreen.dart';
import 'package:quran_application/HadethScreen.dart';
import 'SplashCustom.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quran",
      debugShowCheckedModeBanner: false,
      home: SplashCustom(),
      routes: {
        Home.routeName:(context)=>Home(),
        QuranScreen.routeName:(context)=>QuranScreen(),
        SplashCustom.routeName: (context)=>SplashCustom(),
        TasbeehScreen.routeName: (context)=>TasbeehScreen(),
        HadethScreen.routeName:(context)=>HadethScreen(),
        RadioScreen.routeName:(context)=>RadioScreen(),
      },

    );
  }
}
