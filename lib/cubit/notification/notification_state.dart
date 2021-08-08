part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationInitiated extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationPermitted extends NotificationState {}

class BackgroundServiceLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final bool value;
  NotificationSuccess(this.value);
}

class BackgroundServiceSuccess extends NotificationState {}

class NotificationListenSuccess extends NotificationState {}

class NotificationError extends NotificationState {
  final String errorMessage;
  NotificationError(this.errorMessage);
}

class BackgroundServiceError extends NotificationState {
  final String errorMessage;
  BackgroundServiceError(this.errorMessage);
}
