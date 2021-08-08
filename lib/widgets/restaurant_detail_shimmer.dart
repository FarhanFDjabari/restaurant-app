import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantDetailShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 25,
            color: Colors.white,
            margin: const EdgeInsets.only(top: 20),
          ),
          Container(
            width: 45,
            height: 20,
            color: Colors.white,
            margin: const EdgeInsets.only(top: 8),
          ),
          Container(
            width: double.infinity,
            height: 15,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.only(top: 8),
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 15,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Container(
            width: double.infinity,
            height: 85,
            margin: const EdgeInsets.only(top: 8),
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 15,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Container(
            width: double.infinity,
            height: 85,
            margin: const EdgeInsets.only(top: 8),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
