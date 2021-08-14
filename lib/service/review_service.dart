import 'package:dio/dio.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/model/review/review_response.dart';

class ReviewService {
  Dio _dio = Dio();
  static const BASE_URL = 'https://restaurant-api.dicoding.dev';

  Future<ReviewResponse> addNewReview(
      Dio? mockDio, ReviewRequest reviewRequest) async {
    final dioRequest = mockDio ?? _dio;
    try {
      Response _response = await dioRequest.post(
        BASE_URL + '/review',
        data: reviewRequest.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Auth-Token': 12345,
          },
        ),
      );
      ReviewResponse _reviewResponse = ReviewResponse.fromJson(_response.data);
      if (!_reviewResponse.error)
        return _reviewResponse;
      else
        throw Exception('Internet connection problem');
    } on DioError catch (error) {
      return ReviewResponse.fromJson(error.response!.data);
    }
  }
}
