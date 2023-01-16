import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/util/enums.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  late List<Restaurant?>? _restaurants;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<Restaurant?>? get result => _restaurants;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantResult = await apiService.listRestaurant();
      if (restaurantResult.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurants = restaurantResult.restaurants;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();

      return _message = "Error --> No Internet Connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = "Error --> $e";
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantSearchResult = await apiService.searchRestaurant(query);

      if (restaurantSearchResult.restaurants?.isEmpty ?? false) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurants = restaurantSearchResult.restaurants;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();

      return _message = "Error --> No Internet Connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = "Error --> $e";
    }
  }
}
