import 'package:dio/dio.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant/restaurants_result.dart';
import 'package:restaurant_app/model/restaurant/search_response.dart';

class RestaurantService {
  Dio _dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
    ),
  );
  static const BASE_URL = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> getRestaurantList() async {
    try {
      Response _response = await _dio.get(BASE_URL + '/list');

      RestaurantsResult _restaurantsResult =
          RestaurantsResult.fromJson(_response.data);
      return _restaurantsResult;
    } on DioError catch (error) {
      return RestaurantsResult.fromJson(error.response!.data);
    }
  }

  Future<RestaurantDetailResult> getRestaurantById(String? id) async {
    try {
      Response _response = await _dio.get(BASE_URL + '/detail/$id');
      RestaurantDetailResult _restaurantDetail =
          RestaurantDetailResult.fromJson(_response.data);
      return _restaurantDetail;
    } on DioError catch (error) {
      return RestaurantDetailResult.fromJson(error.response!.data);
    }
  }

  Future<SearchResponse> searchRestaurant(String query) async {
    try {
      Response _response = await _dio.get(BASE_URL + '/search?q=$query');

      return SearchResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return SearchResponse.fromJson(error.response!.data);
    }
  }
}
