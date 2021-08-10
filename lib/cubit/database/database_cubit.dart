import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant/restaurants_result.dart';
import 'package:restaurant_app/service/database_service.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());
  final _databaseService = DatabaseService();

  void initDatabase() async {
    emit(DatabaseLoading());
    try {
      await _databaseService.initDatabase();
      emit(DatabaseInitial());
    } catch (error) {
      emit(DatabaseDataError(error.toString()));
    }
  }

  void getDatabaseData() async {
    emit(DatabaseLoading());
    try {
      final data = await _databaseService.getFavoriteList();
      emit(DatabaseDataLoadSuccess(data));
    } catch (error) {
      emit(DatabaseDataError(error.toString()));
    }
  }

  void insertToFavorite(RestaurantDetail restaurant) async {
    emit(DatabaseLoading());
    try {
      await _databaseService.insertFavorites(restaurant);
      emit(DatabaseDataInsertSuccess());
    } catch (error) {
      emit(DatabaseDataError(error.toString()));
    }
  }

  void isRestaurantFavorite(String id) async {
    final data = await _databaseService.getFavoriteById(id);
    emit(DatabaseDataStatus(data.isNotEmpty));
  }

  void removeDataFromFavorite(RestaurantDetail restaurant) async {
    emit(DatabaseLoading());
    try {
      await _databaseService.removeFavorite(restaurant.id);
      emit(DatabaseDataDeleteSuccess());
    } catch (error) {
      emit(DatabaseDataError(error.toString()));
    }
  }
}
