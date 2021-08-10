import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:restaurant_app/service/datetime_service.dart';

import 'background_service.dart';

class SchedulingService {
  bool _isScheduled = false;

  Future<bool> scheduledNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('scheduled notification on ${DateTimeService.format()}');
      await AndroidAlarmManager.periodic(
        Duration(hours: 23),
        1,
        BackgroundService.callback,
        startAt: DateTimeService.format(),
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
      return true;
    } else {
      print('Schedule Notification Canceled');
      await AndroidAlarmManager.cancel(1);
      return false;
    }
  }

  Future<bool> notificationTest() async {
    return await AndroidAlarmManager.oneShot(
      Duration(seconds: 2),
      2,
      BackgroundService.callback,
      wakeup: true,
      exact: true,
    );
  }
}
