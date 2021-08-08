import 'package:dio/dio.dart';
import 'package:restaurant_app/model/restaurant/search_response.dart';

class SearchService {
  Dio _dio = Dio();
  static const BASE_URL = 'https://restaurant-api.dicoding.dev/';

  Future<SearchResponse> searchRestaurant(String query) async {
    try {
      Response _response = await _dio.get(BASE_URL + '/search?q=$query');

      return SearchResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return SearchResponse.fromJson(error.response!.data);
    }
  }
}
