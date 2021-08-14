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

  Future<RestaurantsResult> getRestaurantList(Dio? mockDio) async {
    final dioRequest = mockDio ?? _dio;
    try {
      Response _response = await dioRequest.get(BASE_URL + '/list');

      RestaurantsResult _restaurantsResult =
          RestaurantsResult.fromJson(_response.data);
      if (!_restaurantsResult.error)
        return _restaurantsResult;
      else
        throw Exception('Failed to fetch restaurant list');
    } on DioError catch (error) {
      return RestaurantsResult.fromJson(error.response!.data);
    }
  }

  Future<RestaurantDetailResult> getRestaurantById(
      Dio? mockDio, String? id) async {
    final dioRequest = mockDio ?? _dio;
    try {
      Response _response = await dioRequest.get(BASE_URL + '/detail/$id');
      RestaurantDetailResult _restaurantDetail =
          RestaurantDetailResult.fromJson(_response.data);
      if (!_restaurantDetail.error)
        return _restaurantDetail;
      else
        throw Exception('Internet connection problem');
    } on DioError catch (error) {
      return RestaurantDetailResult.fromJson(error.response!.data);
    }
  }

  Future<SearchResponse> searchRestaurant(Dio? mockDio, String query) async {
    final dioRequest = mockDio ?? _dio;
    try {
      Response _response = await dioRequest.get(BASE_URL + '/search?q=$query');

      return SearchResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return SearchResponse.fromJson(error.response!.data);
    }
  }
}
