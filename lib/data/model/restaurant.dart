import 'dart:convert';

import 'restaurant_element.dart';

class Restaurant {
  Restaurant({
    required this.restaurants,
  });

  List<RestaurantElement> restaurants;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        restaurants: List<RestaurantElement>.from(
            json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

List<RestaurantElement> restaurantFromJson(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  List<RestaurantElement> parsedRestaurant =
      Restaurant.fromJson(parsed).restaurants;

  return parsedRestaurant;
}

String restaurantToJson(Restaurant data) => json.encode(data.toJson());
