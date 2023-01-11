class Beverage {
  Beverage({
    required this.name,
  });

  String name;

  factory Beverage.fromJson(Map<String, dynamic> json) => Beverage(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
