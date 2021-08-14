import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/model/review/review_response.dart';

class ReviewService {
  static const BASE_URL = 'https://restaurant-api.dicoding.dev';

  Future<ReviewResponse> addNewReview(
      http.Client? client, ReviewRequest reviewRequest) async {
    final _response;
    if (client != null)
      _response = await client.post(
        Uri.parse(BASE_URL + '/review'),
        body: reviewRequest.toJson(),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Auth-Token': '12345',
        },
      );
    else
      _response = await http.post(
        Uri.parse(BASE_URL + '/review'),
        body: reviewRequest.toJson(),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Auth-Token': '12345',
        },
      );
    ReviewResponse _reviewResponse =
        ReviewResponse.fromJson(jsonDecode(_response.body));
    if (_response.statusCode == 200)
      return _reviewResponse;
    else
      throw Exception('Internet connection problem');
  }
}
