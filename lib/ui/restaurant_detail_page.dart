import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/local/db/database_helper.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';
import 'package:resto_app/provider/database_provider.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/ui/add_review_page.dart';
import 'package:resto_app/util/enums.dart';
import 'package:resto_app/widget/error_text.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/restaurant_detail";

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildDetail(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(builder: ((context, provider, _) {
      switch (provider.state) {
        case ResultState.loading:
          return const Center(child: CircularProgressIndicator());
        case ResultState.hasData:
          {
            var restaurantDetail = provider.result.restaurant;

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _buildRestaurantInfo(context, restaurantDetail),
                    const SizedBox(height: 16),
                    _buildRestaurantMenu(context, restaurantDetail?.menus),
                    const SizedBox(height: 16),
                    _buildReviewList(context, restaurantDetail, provider)
                  ],
                ),
              ),
            );
          }
        case ResultState.noData:
        case ResultState.error:
          return ErrorText(errorMessage: provider.message);
        default:
          return const Center(child: Text(''));
      }
    }));
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
            const SizedBox(width: 8),
            RatingBar.builder(
              ignoreGestures: true,
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
        const Divider(color: primaryLightColor, thickness: 1),
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
          _buildBeverageList(context, "Foods", menu.foods),
          const Divider(
            thickness: 1,
            color: primaryLightColor,
            height: 24,
          ),
          _buildBeverageList(context, "Drinks", menu.drinks),
        ] else ...[
          const ErrorText(errorMessage: "Empty Menus")
        ]
      ]),
    );
  }

  Widget _buildBeverageList(
      BuildContext context, String title, List<Category?>? beverages) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.merge(textWhite),
          ),
          const SizedBox(height: 16),
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
        color: primaryLightColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        beverage?.name ?? "-",
        style: Theme.of(context).textTheme.bodySmall?.merge(textBlackBold),
      ),
    );
  }

  Widget _buildReviewList(BuildContext context, RestaurantDetail? restaurant,
      RestaurantDetailProvider provider) {
    List<CustomerReview?>? reviews = restaurant?.customerReviews;
    String? restaurantId = restaurant?.id;

    return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Reviews",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.merge(textWhite),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AddReviewPage.routeName,
                        arguments: restaurantId,
                      ).then((value) {
                        if (value != null && value as bool) {
                          provider.getDetailRestaurant(widget.restaurant.id);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryDarkColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: ((context, index) => const Divider(
                      thickness: 1,
                      color: primaryLightColor,
                    )),
                itemCount: reviews?.length ?? 0,
                itemBuilder: ((context, index) =>
                    _buildReviewItem(context, reviews![index]))),
          ],
        ));
  }

  Widget _buildReviewItem(BuildContext context, CustomerReview? review) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: const BoxDecoration(
                  color: primaryLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  review?.name ?? "-",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.merge(textBlackBold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              review?.date ?? "-",
              style: Theme.of(context).textTheme.caption?.merge(textWhite),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          review?.review ?? "Empty Review",
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.merge(textWhite),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            ChangeNotifierProvider<DatabaseProvider>(
              create: (context) =>
                  DatabaseProvider(databaseHelper: DatabaseHelper()),
              child: _appBar(),
            ),
          ];
        }),
        body: ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider()
              .getDetailRestaurant(widget.restaurant.id),
          child: _buildDetail(context),
        ),
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      actions: [
        Consumer<DatabaseProvider>(
            builder: (context, provider, child) => FutureBuilder<bool>(
                future: provider.isFavorited(widget.restaurant.id),
                builder: ((context, snapshot) {
                  var isFavorited = snapshot.data ?? false;
                  return IconButton(
                    icon: Icon(
                        (isFavorited) ? Icons.favorite : Icons.favorite_border),
                    onPressed: () => (isFavorited)
                        ? provider.removeFavorite(widget.restaurant.id)
                        : provider.addFavorite(widget.restaurant),
                  );
                })))
      ],
      pinned: true,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.restaurant.id,
          child: Stack(children: [
            Positioned.fill(
              child: Image.network(
                ApiService()
                    .picture(widget.restaurant.pictureId!, PictureSize.medium),
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
    );
  }
}
