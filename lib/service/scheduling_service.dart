import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:restaurant_app/service/datetime_service.dart';

import 'background_service.dart';

class SchedulingService {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Notification scheduled on ${DateTimeService.format().toString()}');
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeService.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Schedule Notification Canceled');
      return await AndroidAlarmManager.cancel(1);
    }
  }

  Future<bool> notificationTest() async {
    print('Show notification test');
    return await AndroidAlarmManager.oneShot(
      Duration(seconds: 2),
      2,
      BackgroundService.callback,
      wakeup: true,
      exact: true,
    );
  }
}
