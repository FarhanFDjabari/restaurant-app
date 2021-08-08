part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoadSuccess extends RestaurantState {
  final List<Restaurant> restaurantsList;
  RestaurantLoadSuccess(this.restaurantsList);
}

class RestaurantFounded extends RestaurantState {
  final List<Restaurant> restaurantsList;
  RestaurantFounded(this.restaurantsList);
}

class RestaurantDetailLoadSuccess extends RestaurantState {
  final RestaurantDetail restaurantDetail;
  RestaurantDetailLoadSuccess(this.restaurantDetail);
}

class RestaurantLoadError extends RestaurantState {
  final String errorMessage;
  RestaurantLoadError(this.errorMessage);
}
