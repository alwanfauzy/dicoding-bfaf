import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/local/db/database_helper.dart';
import 'package:resto_app/provider/database_provider.dart';
import 'package:resto_app/util/enums.dart';
import 'package:resto_app/widget/error_text.dart';
import 'package:resto_app/widget/grid_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite";

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(title: const Text("Favorites")),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (context) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Consumer<DatabaseProvider>(
          builder: ((context, state, _) => _consumer(context, state))),
    );
  }

  Widget _consumer(BuildContext context, DatabaseProvider state) {
    switch (state.state) {
      case ResultState.loading:
        return const Center(child: CircularProgressIndicator());
      case ResultState.hasData:
        return GridRestaurant(
          restaurants: state.favorites,
          navigatorCallback: () => state.getFavorites(),
        );
      case ResultState.noData:
      case ResultState.error:
        return ErrorText(errorMessage: state.message);
      default:
        return const Center(child: Text(''));
    }
  }
}
