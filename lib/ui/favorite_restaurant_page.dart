import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/cubit/database/database_cubit.dart';
import 'package:restaurant_app/util/navigation.dart';
import 'package:restaurant_app/widgets/refresh_widget.dart';
import 'package:restaurant_app/widgets/restaurant_list_shimmer.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';

class FavoriteRestaurantPage extends StatefulWidget {
  FavoriteRestaurantPage({Key? key}) : super(key: key);

  @override
  _FavoriteRestaurantPageState createState() => _FavoriteRestaurantPageState();
}

class _FavoriteRestaurantPageState extends State<FavoriteRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DatabaseCubit>(
        create: (context) => DatabaseCubit()..getDatabaseData(),
        child: BlocListener<DatabaseCubit, DatabaseState>(
          listener: (context, state) {
            if (state is DatabaseDataError) {
              Get.showSnackbar(GetBar(
                borderRadius: 15,
                duration: Duration(seconds: 3),
                message: state.errorMessage,
                margin: EdgeInsets.all(10),
                isDismissible: true,
              ));
            }
          },
          child: Stack(
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
                  top: 50.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Navigation.intent('/search', null);
                            },
                            tooltip: 'Search',
                          ),
                          IconButton(
                            onPressed: () {
                              Navigation.intent('/settings', null);
                            },
                            icon: Icon(Icons.settings_outlined),
                            tooltip: 'Settings',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Your Favorite',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .apply(color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Your favorite restaurants listed here',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .apply(color: Colors.black),
                      ),
                    ),
                    BlocBuilder<DatabaseCubit, DatabaseState>(
                      builder: (context, state) {
                        if (state is DatabaseDataLoadSuccess)
                          return Expanded(
                            child: state.restaurantList.length > 0
                                ? RefreshWidget(
                                    onRefresh: () async {
                                      context
                                          .read<DatabaseCubit>()
                                          .getDatabaseData();
                                    },
                                    child: ListView.builder(
                                      itemCount: state.restaurantList.length,
                                      itemExtent: 100.0,
                                      itemBuilder: (context, index) {
                                        final restaurant =
                                            state.restaurantList[index];
                                        return RestaurantTile(
                                          restaurant: restaurant,
                                        );
                                      },
                                    ),
                                  )
                                : RefreshWidget(
                                    onRefresh: () async {
                                      context
                                          .read<DatabaseCubit>()
                                          .getDatabaseData();
                                    },
                                    child: ListView(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 500,
                                          child: Center(
                                            child: Text(
                                              'You have no favorite restaurants',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        else
                          return Expanded(
                            child: RestaurantListShimmer(),
                          );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
