import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/util/enums.dart';
import 'package:resto_app/util/util.dart';
import 'package:resto_app/widget/error_text.dart';

class AddReviewPage extends StatefulWidget {
  static const routeName = "/add_review";

  final String restaurantId;

  const AddReviewPage({super.key, required this.restaurantId});

  @override
  State<StatefulWidget> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  late bool _btnState;

  @override
  void initState() {
    super.initState();
    _btnState = false;
    _nameController.addListener(_controllerListener);
    _reviewController.addListener(_controllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.removeListener(_controllerListener);
    _reviewController.removeListener(_controllerListener);
  }

  _controllerListener() {
    if (_nameController.text.isEmpty || _reviewController.text.isEmpty) {
      setState(() {
        _btnState = false;
      });
    } else {
      setState(() {
        _btnState = true;
      });
    }
  }

  Widget _submitReviewButton() {
    return Consumer<RestaurantDetailProvider>(builder: ((context, provider, _) {
      switch (provider.state) {
        case ResultState.loading:
          return const CircularProgressIndicator();
        case ResultState.noData:
        case ResultState.error:
          showToast(context, provider.message);

          return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: _btnState ? primaryDarkColor : primaryColor),
            onPressed: () {
              _btnState
                  ? ApiService()
                      .addReview(
                        widget.restaurantId,
                        _nameController.text,
                        _reviewController.text,
                      )
                      .then((value) => Navigator.pop(context, true))
                  : showToast(context, "Please don't leave blank");
            },
            child: Text(
              "Submit Review",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _btnState ? Colors.white : primaryLightColor),
            ),
          );
        default:
          return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: _btnState ? primaryDarkColor : primaryColor),
            onPressed: () {
              _btnState
                  ? ApiService()
                      .addReview(
                      widget.restaurantId,
                      _nameController.text,
                      _reviewController.text,
                    )
                      .then((value) {
                      showToast(context, "Review Added");
                      Navigator.pop(context, true);
                    })
                  : showToast(context, "Please don't leave blank");
            },
            child: Text(
              "Submit Review",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _btnState ? Colors.white : primaryLightColor),
            ),
          );
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        title: const Text("Add Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            TextFormField(
              controller: _nameController,
              maxLines: 1,
              style: const TextStyle(
                color: primaryDarkColor,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Nama",
                hintStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                icon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _reviewController,
              maxLines: 5,
              style: const TextStyle(
                color: primaryDarkColor,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Review",
                hintStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                icon: Icon(Icons.edit),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ChangeNotifierProvider(
              create: (_) => RestaurantDetailProvider(),
              child: _submitReviewButton(),
            ),
          ],
        ),
      ),
    );
  }
}
