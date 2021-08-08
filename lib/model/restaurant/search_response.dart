// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:restaurant_app/model/restaurant/restaurants_result.dart';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    required this.error,
    required this.founded,
    required this.foundedRestaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> foundedRestaurants;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        error: json["error"],
        founded: json["founded"],
        foundedRestaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants":
            List<dynamic>.from(foundedRestaurants.map((x) => x.toJson())),
      };
}
