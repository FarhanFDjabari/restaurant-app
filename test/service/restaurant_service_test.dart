import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/service/restaurant_service.dart';

import 'dio_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Dio>(returnNullOnMissingStub: true),
])
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
          "categories": [
            {"name": "Sop"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Kari kacang dan telur"},
              {"name": "Ikan teri dan roti"},
              {"name": "roket penne"},
              {"name": "Salad lengkeng"},
              {"name": "Tumis leek"},
              {"name": "Salad yuzu"},
              {"name": "Sosis squash dan mint"}
            ],
            "drinks": [
              {"name": "Jus tomat"},
              {"name": "Minuman soda"},
              {"name": "Jus apel"},
              {"name": "Jus mangga"},
              {"name": "Es krim"},
              {"name": "Kopi espresso"},
              {"name": "Jus alpukat"},
              {"name": "Coklat panas"},
              {"name": "Es kopi"},
              {"name": "Teh manis"},
              {"name": "Sirup"},
              {"name": "Jus jeruk"}
            ]
          },
          "rating": 4,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak ada duanya!",
              "date": "13 November 2019"
            },
            {
              "name": "Arif",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            },
            {
              "name": "Gilang",
              "review":
                  "Tempatnya bagus namun menurut saya masih sedikit mahal.",
              "date": "14 Agustus 2018"
            },
            {
              "name": "Budi",
              "review": "Makanannya enak",
              "date": "14 Agustus 2021"
            },
            {
              "name": "azis",
              "review": "enak banged",
              "date": "14 Agustus 2021"
            },
            {
              "name": "test",
              "review": "review test",
              "date": "14 Agustus 2021"
            },
            {
              "name": "Bintang",
              "review": "Keren banget restaurantnya",
              "date": "14 Agustus 2021"
            }
          ]
        }
      };

      final httpResponse = Response(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(dio.get('https://restaurant-api.dicoding.dev/detail/$id'))
          .thenAnswer((_) async => httpResponse);

      expect(await RestaurantService().getRestaurantById(dio, id),
          isA<RestaurantDetailResult>());
    });
  });
}
