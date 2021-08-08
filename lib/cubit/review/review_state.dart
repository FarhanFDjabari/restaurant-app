part of 'review_cubit.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewUploadSuccess extends ReviewState {}

class ReviewUploadError extends ReviewState {
  final String errorMessage;
  ReviewUploadError(this.errorMessage);
}
