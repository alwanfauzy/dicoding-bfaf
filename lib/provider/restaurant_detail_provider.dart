import 'dart:io';
import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/customer_review.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';
import 'package:resto_app/util/enums.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  late RestaurantDetailResult _restaurantDetailResult;
  late CustomerReviewResult _customerReviewResult;
  ResultState? _state;
  String _message = '';

  String get message => _message;
  RestaurantDetailResult get result => _restaurantDetailResult;
  CustomerReviewResult get resultReview => _customerReviewResult;
  ResultState? get state => _state;

  RestaurantDetailProvider getDetailRestaurant(String restaurantId) {
    _fetchDetailRestaurant(restaurantId);
    return this;
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
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

  Future<dynamic> addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final customerReview = await apiService.addReview(id, name, review);

      if (customerReview.customerReviews.isNotEmpty) {
        return _message = "Review Added";
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
