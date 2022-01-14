import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_resto/pages/list_restaurant.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = 'splash_screen';
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, ListRestaurantPage.routeName);
    });
  }

  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/the_resto.jpg',
          width: 300,
        ),
      ),
    );
  }
}
