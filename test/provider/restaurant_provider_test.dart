import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_search.dart';
import 'package:resto_app/provider/restaurant_provider.dart';

import 'restaurant_provider_test.mocks.dart';

class ApiServiceTest extends Mock implements ApiService {}

const apiListResponse = {
  "error": false,
  "message": "success",
  "count": 2,
  "restaurants": [
    {
      "id": "w9pga3s2tubkfw1e867",
      "name": "Bring Your Phone Cafe",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "03",
      "city": "Surabaya",
      "rating": 4.2
    },
    {
      "id": "uewq1zg2zlskfw1e867",
      "name": "Kafein",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "15",
      "city": "Aceh",
      "rating": 4.6
    },
  ]
};

const apiSearchResponse = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "w9pga3s2tubkfw1e867",
      "name": "Bring Your Phone Cafe",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "03",
      "city": "Surabaya",
      "rating": 4.2
    }
  ]
};

List<Restaurant> testRestaurants = [
  Restaurant(
    id: "w9pga3s2tubkfw1e867",
    name: "Bring Your Phone Cafe",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "03",
    city: "Surabaya",
    rating: 4.2,
  ),
  Restaurant(
    id: "uewq1zg2zlskfw1e867",
    name: "Kafein",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "15",
    city: "Aceh",
    rating: 4.6,
  ),
];

List<Restaurant> testSearchRestaurants = [
  Restaurant(
    id: "w9pga3s2tubkfw1e867",
    name: "Bring Your Phone Cafe",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "03",
    city: "Surabaya",
    rating: 4.2,
  ),
];

@GenerateMocks([ApiServiceTest])
Future<void> main() async {
  group("Restaurant Provider Test", () {
    late RestaurantProvider restaurantProvider;
    late ApiService apiService;

    setUp(() {
      apiService = MockApiServiceTest();
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test("fetchAllRestaurant should return list of restaurants", () async {
      when(apiService.listRestaurant())
          .thenAnswer((_) async => RestaurantResult.fromJson(apiListResponse));

      await restaurantProvider.fetchAllRestaurant();

      var result = restaurantProvider.result!;
      var expected = testRestaurants;

      expect(result.length == expected.length, true);
      expect(result[0]?.id == expected[0].id, true);
      expect(result[0]?.name == expected[0].name, true);
      expect(result[0]?.description == expected[0].description, true);
      expect(result[0]?.pictureId == expected[0].pictureId, true);
      expect(result[0]?.city == expected[0].city, true);
      expect(result[0]?.rating == expected[0].rating, true);
    });

    test("searchRestaurant should return queried restaurants", () async {
      when(apiService.searchRestaurant("bring")).thenAnswer(
          (_) async => RestaurantSearchResult.fromJson(apiSearchResponse));

      await restaurantProvider.searchRestaurant("bring");

      var result = restaurantProvider.result!;
      var expected = testSearchRestaurants;

      expect(result.length == expected.length, true);
      expect(result[0]?.id == expected[0].id, true);
      expect(result[0]?.name == expected[0].name, true);
      expect(result[0]?.description == expected[0].description, true);
      expect(result[0]?.pictureId == expected[0].pictureId, true);
      expect(result[0]?.city == expected[0].city, true);
      expect(result[0]?.rating == expected[0].rating, true);
    });
  });
}
