import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/util/enums.dart';
import 'package:resto_app/widget/error_text.dart';
import 'package:resto_app/widget/grid_restaurant.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = "/favorite";

  FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(title: const Text("Favorites")),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => RestaurantProvider(apiService: ApiService()),
      child: Consumer<RestaurantProvider>(
          builder: ((context, state, _) => _consumer(context, state))),
    );
  }

  Widget _consumer(BuildContext context, RestaurantProvider state) {
    switch (state.state) {
      case ResultState.loading:
        return const Center(child: CircularProgressIndicator());
      case ResultState.hasData:
        return GridRestaurant(restaurants: state.result ?? List.empty());
      case ResultState.noData:
      case ResultState.error:
        return ErrorText(errorMessage: state.message);
      default:
        return const Center(child: Text(''));
    }
  }
}
