import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';
import 'package:resto_app/widget/error_text.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/restaurant_detail";

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<RestaurantDetailResult> _restaurantDetail;

  @override
  void initState() {
    super.initState();
    _restaurantDetail = ApiService().detailRestaurant(widget.restaurant.id);
  }

  Widget _buildDetail(BuildContext context) {
    return FutureBuilder(
      future: _restaurantDetail,
      builder: ((context, AsyncSnapshot<RestaurantDetailResult> snapshot) {
        try {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var restaurantDetail = snapshot.data?.restaurant;

              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      _buildRestaurantInfo(context, restaurantDetail),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildRestaurantMenu(context, restaurantDetail?.menus)
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const ErrorText(errorMessage: "Connection Error");
            } else {
              return const Text('');
            }
          }
        } catch (e) {
          return ErrorText(errorMessage: e.toString());
        }
      }),
    );
  }

  Widget _buildRestaurantInfo(BuildContext context, RestaurantDetail? detail) {
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
                    detail?.city ?? "-",
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
              initialRating: detail?.rating ?? 0,
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
          detail?.description ?? "Empty Description",
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium?.merge(textWhite),
        )
      ]),
    );
  }

  Widget _buildRestaurantMenu(BuildContext context, Menus? menu) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (menu != null) ...[
          _buildBeverageList(context, "Available Foods", menu.foods),
          const Divider(thickness: 1, color: primaryLightColor),
          _buildBeverageList(context, "Available Drinks", menu.drinks),
        ] else ...[
          const ErrorText(errorMessage: "Empty Menus")
        ]
      ]),
    );
  }

  Widget _buildBeverageList(
      BuildContext context, String title, List<Category?>? beverages) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.merge(textWhite),
      ),
      const SizedBox(
        height: 8,
      ),
      if (beverages == null) ...[
        const ErrorText(errorMessage: "Empty"),
      ] else ...[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(beverages.length,
              (index) => _buildBeverageItem(context, beverages[index])),
        ),
      ]
    ]);
  }

  Widget _buildBeverageItem(BuildContext context, Category? beverage) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: const BoxDecoration(
        color: primaryDarkColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        beverage?.name ?? "-",
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
                    tag: widget.restaurant.id,
                    child: Stack(children: [
                      Positioned.fill(
                        child: Image.network(
                          ApiService().picture(
                              widget.restaurant.pictureId!, PictureSize.medium),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.6),
                      )
                    ]),
                  ),
                  title: Text(widget.restaurant.name),
                  titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
                ),
              ),
            ];
          }),
          body: _buildDetail(context)),
    );
  }
}
