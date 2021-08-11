import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/service/background_service.dart';
import 'package:restaurant_app/service/notification_service.dart';
import 'package:restaurant_app/service/scheduling_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  NotificationService _notificationService = NotificationService();
  SchedulingService _schedulingService = SchedulingService();
  BackgroundService _backgroundService = BackgroundService();

  void initNotification(FlutterLocalNotificationsPlugin flp) async {
    emit(NotificationLoading());
    try {
      await _notificationService.initNotification(flp);
      emit(NotificationInitiated());
    } catch (error) {
      emit(NotificationError(error.toString()));
    }
  }

  void initBackgroundService() {
    emit(NotificationLoading());
    try {
      _backgroundService.initializeIsolate();
      emit(BackgroundServiceSuccess());
    } catch (error) {
      emit(BackgroundServiceError(error.toString()));
    }
  }

  void scheduleNotification(bool value) async {
    emit(NotificationLoading());
    try {
      final result = await _schedulingService.scheduledNotification(value);
      await GetStorage().write('is_notification_scheduled', value);
      emit(NotificationSuccess(result));
    } catch (error) {
      emit(NotificationError(error.toString()));
    }
  }

  void showTestNotification() async {
    emit(NotificationLoading());
    try {
      final result = await _schedulingService.notificationTest();
      emit(NotificationSuccess(result));
    } catch (error) {
      emit(NotificationError(error.toString()));
    }
  }

  void activateNotificationListener(String route) {
    emit(NotificationLoading());
    try {
      _notificationService.configureSelectNotificationSubject(route);
      emit(NotificationListenSuccess());
    } catch (error) {
      emit(NotificationError(error.toString()));
    }
  }
}
