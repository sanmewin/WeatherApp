import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => WeatherApp(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffcbcbe2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Welcome to😀",
            style: TextStyle(
                color: (MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          )),
          Center(
              child: Text("🌧",
                  style: TextStyle(
                      color: (MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                      fontWeight: FontWeight.bold,
                      fontSize: 110))),
          Center(
              child: Text(
            "Weather",
            style: TextStyle(
                color: (MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          )),
        ],
      ),
    );
  }
}
