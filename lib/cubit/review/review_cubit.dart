import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/service/review_service.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  ReviewService _reviewService = ReviewService();

  void addNewReview(ReviewRequest reviewRequest) async {
    emit(ReviewLoading());
    try {
      await _reviewService.addNewReview(reviewRequest);
      emit(ReviewUploadSuccess());
    } catch (error) {
      emit(ReviewUploadError(error.toString()));
    }
  }
}
