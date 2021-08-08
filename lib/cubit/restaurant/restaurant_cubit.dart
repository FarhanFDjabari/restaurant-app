import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant/restaurants_result.dart';
import 'package:restaurant_app/model/restaurant/search_response.dart';
import 'package:restaurant_app/service/restaurant_service.dart';
import 'package:restaurant_app/service/search_service.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(RestaurantInitial());
  RestaurantService _restaurantService = RestaurantService();
  SearchService _searchService = SearchService();

  void getAllRestaurants() async {
    emit(RestaurantLoading());
    try {
      final restaurantsList = await _restaurantService.getRestaurantList();
      emit(RestaurantLoadSuccess(restaurantsList.restaurants));
    } catch (error) {
      emit(RestaurantLoadError(error.toString()));
    }
  }

  void getRestaurantById(String id) async {
    emit(RestaurantLoading());
    try {
      final restaurantDetail = await _restaurantService.getRestaurantById(id);
      emit(RestaurantDetailLoadSuccess(restaurantDetail.restaurantDetail));
    } catch (error) {
      emit(RestaurantLoadError(error.toString()));
    }
  }

  void searchRestaurant(String title) async {
    emit(RestaurantLoading());
    try {
      final restaurantsList = await _searchService.searchRestaurant(title);
      emit(RestaurantFounded(restaurantsList.foundedRestaurants));
    } catch (error) {
      emit(RestaurantLoadError(error.toString()));
    }
  }
}