import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/model/review/review_response.dart';
import 'package:restaurant_app/service/review_service.dart';

import 'dio_test.mocks.dart';

void main() {
  test(
      'given review request, should return ReviewResponse when module completed',
      () async {
    final dio = MockDio();

    final reviewRequest = ReviewRequest(
      id: 's1knt6za9kkfw1e867',
      name: 'test',
      review: 'review test',
    );

    final Map<String, dynamic> responsePayload = {
      'error': false,
      'message': 'success',
      'customerReviews': [
        {
          'name': 'test',
          'review': 'review test',
          'date': '14 Agustus 2021',
        }
      ],
    };

    final httpResponse = Response(
      data: responsePayload,
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    when(dio.post(
      'https://restaurant-api.dicoding.dev/review',
      data: reviewRequest.toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'X-Auth-Token': 12345,
        },
      ),
    )).thenAnswer((_) async => httpResponse);

    expect(await ReviewService().addNewReview(reviewRequest),
        isA<ReviewResponse>());
  });
}
