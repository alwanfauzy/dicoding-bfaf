import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'package:resto_app/util/enums.dart';

class GridRestaurant extends StatelessWidget {
  final List<Restaurant?> restaurants;

  const GridRestaurant({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(
        restaurants.length,
        (index) => _buildRestaurantItem(context, restaurants[index]),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant? restaurant) {
    double starSize = MediaQuery.of(context).size.width * 0.03;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: () => Navigator.pushNamed(
        context,
        RestaurantDetailPage.routeName,
        arguments: restaurant,
      ),
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
            title: Text(restaurant?.name ?? "-",
                style:
                    Theme.of(context).textTheme.bodyMedium?.merge(textWhite)),
            subtitle: Text(restaurant?.city ?? "-",
                style: Theme.of(context).textTheme.bodySmall?.merge(textWhite)),
          ),
          footer: GridTileBar(
            title: RatingBar.builder(
              initialRating: restaurant?.rating ?? 0,
              ignoreGestures: true,
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
            tag: restaurant!.id,
            child: Stack(children: [
              Positioned.fill(
                child: Image.network(
                  ApiService().picture(
                    restaurant.pictureId!,
                    PictureSize.small,
                  ),
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
}
