import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/ui/favorite_page.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'package:resto_app/ui/settings_page.dart';
import 'package:resto_app/util/enums.dart';
import 'package:resto_app/util/notification_helper.dart';
import 'package:resto_app/widget/error_text.dart';
import 'package:resto_app/widget/grid_restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/restaurant_list_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  String _searchText = "";
  Timer? _debounce;

  void _onSearchChanged(String query, RestaurantProvider provider) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        provider.fetchAllRestaurant();
      } else if (_searchText != query) {
        _searchText = query;
        provider.searchRestaurant(_searchText);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      RestaurantDetailPage.routeName,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (context) => RestaurantProvider(apiService: ApiService()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<RestaurantProvider>(
              builder: ((context, provider, _) => _header(context, provider)),
            ),
            Consumer<RestaurantProvider>(
              builder: ((context, state, _) =>
                  Expanded(child: _body(context, state))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, RestaurantProvider provider) {
    return Container(
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, FavoritePage.routeName),
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SettingsPage.routeName),
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      )),
                ],
              ),
              const Text(
                "Restaurant",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: primaryLightColor,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  onChanged: (text) => _onSearchChanged(text, provider),
                  textAlignVertical: TextAlignVertical.center,
                  style:
                      Theme.of(context).textTheme.bodyMedium?.merge(textWhite),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Search you're looking for",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, RestaurantProvider state) {
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
