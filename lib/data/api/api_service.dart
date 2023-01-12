import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _getListRestaurant = "$_baseUrl/list";
  static const String _getDetailRestaurant = "$_baseUrl/detail";
  static const String _getPicture = "$_baseUrl/images";

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse(_getListRestaurant));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantDetailResult> detailRestaurant(String id) async {
    String url = "$_getDetailRestaurant/$id";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  String picture(String pictureId, PictureSize pictureSize) {
    switch (pictureSize) {
      case PictureSize.small:
        return "$_getPicture/small/$pictureId";
      case PictureSize.medium:
        return "$_getPicture/medium/$pictureId";
      case PictureSize.big:
        return "$_getPicture/big/$pictureId";
    }
  }
}

enum PictureSize { small, medium, big }
