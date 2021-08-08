import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/cubit/notification/notification_cubit.dart';
import 'package:restaurant_app/cubit/restaurant/restaurant_cubit.dart';
import 'package:restaurant_app/util/navigation.dart';
import 'package:restaurant_app/widgets/refresh_widget.dart';
import 'package:restaurant_app/widgets/restaurant_animation_container.dart';
import 'package:restaurant_app/widgets/restaurant_list_shimmer.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';

class RestaurantListPage extends StatefulWidget {
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final NotificationCubit _notificationCubit = NotificationCubit();

  @override
  void initState() {
    super.initState();

    _notificationCubit.getNotificationPermission();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
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
                      ),
                      IconButton(
                        onPressed: () {
                          Navigation.intent('/settings', null);
                        },
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Restaurant',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Recommendation restaurant for you!',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .apply(color: Colors.black),
                  ),
                ),
                Expanded(
                  child: BlocProvider<RestaurantCubit>(
                    create: (context) => RestaurantCubit()..getAllRestaurants(),
                    child: BlocConsumer<RestaurantCubit, RestaurantState>(
                      listener: (context, state) {
                        if (state is RestaurantLoadError) {
                          Get.showSnackbar(GetBar(
                            message: state.errorMessage,
                            margin: EdgeInsets.all(10),
                            duration: Duration(seconds: 4),
                            borderRadius: 15,
                          ));
                        }
                      },
                      builder: (context, state) {
                        if (state is RestaurantLoadSuccess)
                          return RestaurantAnimationContainer(
                            animationController: _animationController,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                            child: RefreshWidget(
                              onRefresh: () async {
                                context
                                    .read<RestaurantCubit>()
                                    .getAllRestaurants();
                              },
                              child: ListView.builder(
                                itemCount: state.restaurantsList.length,
                                itemExtent: 100.0,
                                itemBuilder: (context, index) {
                                  final restaurant =
                                      state.restaurantsList[index];
                                  return RestaurantTile(restaurant: restaurant);
                                },
                              ),
                            ),
                          );
                        else if (state is RestaurantLoading)
                          return RestaurantListShimmer();
                        else
                          return RefreshWidget(
                              onRefresh: () async {
                                context
                                    .read<RestaurantCubit>()
                                    .getAllRestaurants();
                              },
                              child: ListView(
                                children: [
                                  Text('Restaurant not found'),
                                ],
                              ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
