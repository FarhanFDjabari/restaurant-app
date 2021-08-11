import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

Widget createReviewDialog() {
  return MaterialApp(
    home: RestaurantReviewDialog(
      id: 's1knt6za9kkfw1e867',
    ),
  );
}

void main() {
  group('Review Dialog Widget Test', () {
    testWidgets('Should find send review button on Restaurant List Page',
        (tester) async {
      await tester.pumpWidget(createReviewDialog());
      expect(find.byKey(Key('send_review_button')), findsOneWidget);
    });
  });
}
