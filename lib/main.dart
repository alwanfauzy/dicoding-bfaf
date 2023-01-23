import 'package:flutter/material.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/ui/add_review_page.dart';
import 'package:resto_app/ui/home_page.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'common/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Resto App",
      theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: primaryTextColor,
                secondary: secondaryColor,
                onSecondary: secondaryTextColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: textTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)))))),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: ((context) => const HomePage()),
        RestaurantDetailPage.routeName: ((context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            )),
        AddReviewPage.routeName: ((context) => AddReviewPage(
            restaurantId:
                ModalRoute.of(context)?.settings.arguments as String)),
      },
    );
  }
}
