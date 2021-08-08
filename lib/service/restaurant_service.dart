import 'package:dio/dio.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant/restaurants_result.dart';

class RestaurantService {
  Dio _dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 10 * 1000,
      receiveTimeout: 20 * 1000,
    ),
  );
  static const BASE_URL = 'https://restaurant-api.dicoding.dev/';
  // image url: images/small/{pictureId}

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

  Future<RestaurantDetailResult> getRestaurantById(String id) async {
    try {
      Response _response = await _dio.get(BASE_URL + '/detail/$id');
      RestaurantDetailResult _restaurantDetail =
          RestaurantDetailResult.fromJson(_response.data);
      return _restaurantDetail;
    } on DioError catch (error) {
      return RestaurantDetailResult.fromJson(error.response!.data);
    }
  }
}
