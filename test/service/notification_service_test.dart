import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/service/notification_service.dart';

void main() {
  test(
      'given test flutter local notification, should return true when initialized',
      () async {
    FlutterLocalNotificationsPlugin testFlp = FlutterLocalNotificationsPlugin();
    NotificationService notificationService = NotificationService();

    final result = await notificationService.initNotification(testFlp);
    expect(result, true);
  });
}
