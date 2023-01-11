import 'beverage.dart';

class Menu {
  Menu({
    required this.foods,
    required this.drinks,
  });

  List<Beverage> foods;
  List<Beverage> drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods:
            List<Beverage>.from(json["foods"].map((x) => Beverage.fromJson(x))),
        drinks: List<Beverage>.from(
            json["drinks"].map((x) => Beverage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
