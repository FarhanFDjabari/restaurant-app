import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/service/review_service.dart';

void main() {
  test(
      'given review request, should return ReviewResponse when module completed',
      () async {
    ReviewService reviewService = ReviewService();
    final reviewRequest = ReviewRequest(
      id: 's1knt6za9kkfw1e867',
      name: 'test',
      review: 'review test',
    );

    final result = await reviewService.addNewReview(reviewRequest);
    expect(result.error, false);
  });
}
