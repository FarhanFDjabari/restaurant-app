import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';

class RestaurantMenuTile extends StatelessWidget {
  const RestaurantMenuTile({
    Key? key,
    this.restaurantMenuData,
  }) : super(key: key);

  final Category? restaurantMenuData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.multiply,
                ),
                child: restaurantMenuData!.picture != null
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/food-plate.png',
                        image:
                            'https://restaurant-api.dicoding.dev/images/small/${restaurantMenuData!.picture!}',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/food-plate.png',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
          if (restaurantMenuData!.picture == null)
            Positioned.fill(
              child: Center(
                child: Text(
                  'Failed to fetch picture',
                  style: Theme.of(context)
                      .textTheme
                      .overline!
                      .apply(color: Colors.white),
                ),
              ),
            ),
          Positioned(
            left: 10,
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantMenuData!.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .apply(color: Colors.white),
                ),
                Text(
                  restaurantMenuData!.price == null
                      ? 'IDR 0'
                      : 'IDR ${restaurantMenuData!.price}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
