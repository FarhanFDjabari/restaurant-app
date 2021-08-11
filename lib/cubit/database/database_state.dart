part of 'database_cubit.dart';

@immutable
abstract class DatabaseState {}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoading extends DatabaseState {}

class DatabaseDataLoadSuccess extends DatabaseState {
  final List<Restaurant> restaurantList;

  DatabaseDataLoadSuccess(this.restaurantList);
}

class DatabaseDataStatus extends DatabaseState {
  final bool status;

  DatabaseDataStatus(this.status);
}

class DatabaseDataInsertSuccess extends DatabaseState {}

class DatabaseDataSaveSuccess extends DatabaseState {}

class DatabaseDataDeleteSuccess extends DatabaseState {}

class DatabaseDataError extends DatabaseState {
  final String errorMessage;

  DatabaseDataError(this.errorMessage);
}
