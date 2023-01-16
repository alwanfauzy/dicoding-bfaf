import 'dart:convert';
import 'package:resto_app/data/model/restaurant.dart';

class RestaurantSearchResult {
  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool? error;
  int? founded;
  List<Restaurant?>? restaurants;

  factory RestaurantSearchResult.fromRawJson(String str) =>
      RestaurantSearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant?>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x!.toJson())),
      };
}
