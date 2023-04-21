import 'package:flutter/material.dart';
import 'package:resto_app/data/local/db/database_helper.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/util/enums.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void getFavorites() async {
    _state = ResultState.loading;
    _favorites = await databaseHelper.getFavorites();

    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = "Empty Favorites, please add your favorite restaurant!";
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error when add favorite, $e';
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Error when deleting favorite, $e";
    }
  }

  Future<bool> isFavorited(String id) async {
    return (await databaseHelper.getFavoriteById(id)).isNotEmpty;
  }
}
