import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';

class ReviewTile extends StatelessWidget {
  final CustomerReview customerReview;
  ReviewTile({required this.customerReview});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.grey.withOpacity(0.1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              customerReview.date,
              style: Theme.of(context).textTheme.overline,
            ),
            SizedBox(height: 5),
            Text(
              customerReview.name,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 3),
            Text(
              customerReview.review,
              style: Theme.of(context).textTheme.bodyText2,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
