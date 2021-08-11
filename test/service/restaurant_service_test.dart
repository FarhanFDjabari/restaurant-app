import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/service/restaurant_service.dart';

void main() {
  group('Restaurant Service Test', () {
    test('should return RestaurantResult when module completed', () async {
      RestaurantService restaurantService = RestaurantService();
      final result = await restaurantService.getRestaurantList();
      expect(result.restaurants.isNotEmpty, true);
    });

    test(
        'given id s1knt6za9kkfw1e867, should return RestaurantDetailData when module complete',
        () async {
      RestaurantService restaurantService = RestaurantService();
      String id = 's1knt6za9kkfw1e867';

      final result = await restaurantService.getRestaurantById(id);
      expect(result.error, false);
    });
  });
}
