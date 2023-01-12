import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_element.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'package:resto_app/widget/error_text.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/restaurant_list_page";

  const HomePage({super.key});

  Widget _buildHeader(BuildContext context) {
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
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Discover",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const Text(
                "Restaurant",
                style: TextStyle(
                    fontSize: 49,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: primaryLightColor,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style:
                      Theme.of(context).textTheme.bodyText2?.merge(textWhite),
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

  Widget _buildRestaurantGrid(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          try {
            final List<RestaurantElement> restaurants =
                restaurantFromJson(snapshot.data);

            return GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: List.generate(restaurants.length,
                  (index) => _buildRestaurantItem(context, restaurants[index])),
            );
          } catch (e) {
            return ErrorText(error: e);
          }
        });
  }

  Widget _buildRestaurantItem(
      BuildContext context, RestaurantElement restaurant) {
    double starSize = MediaQuery.of(context).size.width * 0.03;
    String pictureUrl = restaurant.pictureId;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: () => Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: GridTile(
          header: GridTileBar(
            leading: const CircleAvatar(
              radius: 16,
              backgroundColor: primaryLightColor,
              child: Icon(
                Icons.restaurant_menu,
                color: primaryColor,
              ),
            ),
            title: Text(restaurant.name,
                style:
                    Theme.of(context).textTheme.bodyMedium?.merge(textWhite)),
            subtitle: Text(restaurant.city,
                style: Theme.of(context).textTheme.bodySmall?.merge(textWhite)),
          ),
          footer: GridTileBar(
            title: RatingBar.builder(
              initialRating: restaurant.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: starSize,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: secondaryLightColor,
              ),
              onRatingUpdate: (rating) {},
            ),
          ),
          child: Hero(
            tag: pictureUrl,
            child: Stack(children: [
              Positioned.fill(
                child: Image.network(
                  pictureUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.6),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryLightColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(child: _buildRestaurantGrid(context)),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }
}
