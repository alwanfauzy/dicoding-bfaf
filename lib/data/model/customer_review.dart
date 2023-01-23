import 'dart:convert';
import 'package:resto_app/data/model/restaurant_detail.dart';

class CustomerReviewResult {
  CustomerReviewResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory CustomerReviewResult.fromRawJson(String str) =>
      CustomerReviewResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerReviewResult.fromJson(Map<String, dynamic> json) =>
      CustomerReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
