import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';
import 'package:resto_app/util/enums.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant();
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get result => _restaurantDetailResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantDetail = await apiService.detailRestaurant(id);

      if (restaurantDetail.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantDetailResult = restaurantDetail;
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
