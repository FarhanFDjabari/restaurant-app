import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant/restaurants_result.dart';
import 'package:restaurant_app/model/restaurant/search_response.dart';

class RestaurantService {
  static const BASE_URL = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> getRestaurantList(http.Client? client) async {
    final _response;

    if (client != null)
      _response = await client.get(Uri.parse(BASE_URL + '/list'));
    else
      _response = await http.get(Uri.parse(BASE_URL + '/list'));

    RestaurantsResult _restaurantsResult =
        RestaurantsResult.fromJson(jsonDecode(_response.body));

    if (!_restaurantsResult.error)
      return _restaurantsResult;
    else
      throw Exception('Failed to fetch restaurant list');
  }

  Future<RestaurantDetailResult> getRestaurantById(
      http.Client? client, String? id) async {
    final _response;

    if (client != null)
      _response = await client.get(Uri.parse(BASE_URL + '/detail/$id'));
    else
      _response = await http.get(Uri.parse(BASE_URL + '/detail/$id'));

    RestaurantDetailResult _restaurantDetail =
        RestaurantDetailResult.fromJson(jsonDecode(_response.body));

    if (!_restaurantDetail.error)
      return _restaurantDetail;
    else
      throw Exception('Internet connection error');
  }

  Future<SearchResponse> searchRestaurant(
      http.Client? client, String query) async {
    final _response;

    if (client != null)
      _response = await client.get(Uri.parse(BASE_URL + '/search?q=$query'));
    else
      _response = await http.get(Uri.parse(BASE_URL + '/search?q=$query'));

    SearchResponse _searchResponse =
        SearchResponse.fromJson(jsonDecode(_response.body));

    if (!_searchResponse.error)
      return _searchResponse;
    else
      throw Exception('Internet connection error');
  }
}
