import 'package:flutter/material.dart';
import 'package:the_resto/model/restaurant.dart';
import 'package:the_resto/pages/detail_restaurant.dart';
import 'package:the_resto/pages/list_restaurant.dart';
import 'package:the_resto/pages/splash_screen.dart';
import 'package:the_resto/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Resto',
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: myTextTheme,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        ListRestaurantPage.routeName: (context) => ListRestaurantPage(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
