import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/service/restaurant_service.dart';

import 'dio_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('Restaurant Service Test', () {
    test('given id s1knt6za9kkfw1e867, should return data when module complete',
        () async {
      final dio = MockDio();
      String id = 's1knt6za9kkfw1e867';

      final Map<String, dynamic> responsePayload = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
          "city": "Gorontalo",
          "address": "Jln. Pustakawan no 9",
          "pictureId": "25",
          "categories": [],
          "menus": {},
          "rating": 4,
          "customerReviews": []
        }
      };

      final httpResponse = Response(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(dio.get('https://restaurant-api.dicoding.dev/detail/$id'))
          .thenAnswer((_) async => httpResponse);

      expect(await RestaurantService().getRestaurantById(id),
          isA<RestaurantDetailResult>());
    });
  });
}
