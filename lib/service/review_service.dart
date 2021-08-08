import 'package:dio/dio.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/model/review/review_response.dart';

class ReviewService {
  Dio _dio = Dio();
  static const BASE_URL = 'https://restaurant-api.dicoding.dev/';

  Future<ReviewResponse> addNewReview(ReviewRequest reviewRequest) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + '/review',
        data: reviewRequest.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Auth-Token': 12345,
          },
        ),
      );
      return ReviewResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return ReviewResponse.fromJson(error.response!.data);
    }
  }
}
