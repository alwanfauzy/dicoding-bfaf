import 'package:flutter_test/flutter_test.dart';
import 'package:resto_app/data/model/restaurant.dart';

var testJsonRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

void main() {
  test("Json Parsing Test", () async {
    var expected = "rqdv5juczeskfw1e867";
    var result = Restaurant.fromJson(testJsonRestaurant).id;

    expect(result, expected);
  });
}
