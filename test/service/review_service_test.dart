import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/model/review/review_response.dart';
import 'package:restaurant_app/service/review_service.dart';

import 'http_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test(
    'given review request, should return ReviewResponse when module completed',
    () async {
      final client = MockClient();

      final reviewRequest = ReviewRequest(
        id: 's1knt6za9kkfw1e867',
        name: 'test',
        review: 'review test',
      );

      final responsePayload = {
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

      when(
        client.post(
          Uri.parse('https://restaurant-api.dicoding.dev/review'),
          body: reviewRequest.toJson(),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Auth-Token': '12345',
          },
        ),
      ).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      expect(
        await ReviewService().addNewReview(client, reviewRequest),
        isA<ReviewResponse>(),
      );
    },
  );
}
