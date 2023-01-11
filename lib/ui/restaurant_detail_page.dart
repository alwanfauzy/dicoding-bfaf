import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/model/restaurant_element.dart';

import '../data/model/beverage.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = "/restaurant_detail";

  final RestaurantElement restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  Widget _buildRestaurantInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: primaryLightColor,
                    child: Icon(
                      Icons.location_pin,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    restaurant.city,
                    style:
                        Theme.of(context).textTheme.bodyLarge?.merge(textWhite),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            RatingBar.builder(
              initialRating: restaurant.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: secondaryLightColor,
              ),
              onRatingUpdate: (rating) {},
            ),
          ],
        ),
        const Divider(
          color: primaryLightColor,
          thickness: 1,
        ),
        Text(
          restaurant.description,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium?.merge(textWhite),
        )
      ]),
    );
  }

  Widget _buildRestaurantMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildBeverageList(context, "Available Foods", restaurant.menus.foods),
        const Divider(
          thickness: 1,
          color: primaryLightColor,
        ),
        _buildBeverageList(
            context, "Available Drinks", restaurant.menus.drinks),
      ]),
    );
  }

  Widget _buildBeverageList(
      BuildContext context, String title, List<Beverage> beverages) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.merge(textWhite),
      ),
      const SizedBox(
        height: 8,
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(beverages.length,
            (index) => _buildBeverageItem(context, beverages[index])),
      )
    ]);
  }

  Widget _buildBeverageItem(BuildContext context, Beverage beverage) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: const BoxDecoration(
        color: primaryDarkColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        beverage.name,
        style: Theme.of(context).textTheme.bodySmall?.merge(textWhite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: restaurant.pictureId,
                  child: Stack(children: [
                    Positioned.fill(
                      child: Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.6),
                    )
                  ]),
                ),
                title: Text(restaurant.name),
                titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
              ),
            ),
          ];
        }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                _buildRestaurantInfo(context),
                const SizedBox(
                  height: 16,
                ),
                _buildRestaurantMenu(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
