import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/cubit/restaurant/restaurant_cubit.dart';
import 'package:restaurant_app/widgets/restaurant_list_shimmer.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantCubit>(
      create: (context) => RestaurantCubit()..searchRestaurant(''),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50)),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                  ),
                )),
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(
                top: 70.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Search',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .apply(color: Colors.black),
                      ),
                    ),
                    BlocConsumer<RestaurantCubit, RestaurantState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Center(
                            child: TextField(
                              autofocus: false,
                              controller: _searchController,
                              cursorColor: Colors.amber,
                              onChanged: (value) {
                                if (value != '')
                                  context
                                      .read<RestaurantCubit>()
                                      .searchRestaurant(value);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                hintText: 'Search...',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: BlocConsumer<RestaurantCubit, RestaurantState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is RestaurantFounded)
                            return state.restaurantsList.length > 0
                                ? ListView.builder(
                                    itemCount: state.restaurantsList.length,
                                    itemExtent: 100,
                                    itemBuilder: (context, index) {
                                      return RestaurantTile(
                                          restaurant:
                                              state.restaurantsList[index]);
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      'Restaurant not found',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  );
                          else if (state is RestaurantLoading)
                            return Center(
                              child: RestaurantListShimmer(),
                            );
                          else
                            return Center(
                              child: Text(
                                'Search your restaurant',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
