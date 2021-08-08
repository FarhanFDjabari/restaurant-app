import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';

class NotificationService {
  static NotificationService? _instance;

  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();

  Future<void> initNotification(FlutterLocalNotificationsPlugin flp) async {
    print('initiating notification channel');

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flp.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
    });
  }

  Future<void> getPermission() async {}

  Future<void> showNotification(FlutterLocalNotificationsPlugin flp,
      RestaurantDetail restaurantDetail) async {
    var _channelId = "1";
    var _channelName = "restaurant_01";
    var _channelDescription = "Restaurant notification channel";
    String notificationTitle = 'Restoran Baru yang Bisa <b>Kamu</b> Kunjungi!!';
    String notificationContent =
        '${restaurantDetail.name} located in ${restaurantDetail.city}';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        sound: RawResourceAndroidNotificationSound('slow_spring_board'),
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentSound: false,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flp.show(
      0,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: json.encode(restaurantDetail.toJson()),
    );
  }

  void notificationListener(String route) {}
}
