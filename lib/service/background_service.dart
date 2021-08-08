import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_app/service/notification_service.dart';
import 'package:restaurant_app/service/restaurant_service.dart';

import '../main.dart';

final ReceivePort receivePort = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() => _service ?? BackgroundService._createObject();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print("show notification");
    final NotificationService _notificationService = NotificationService();
    final RestaurantService _restaurantService = RestaurantService();

    final _restaurantData =
        await _restaurantService.getRestaurantById("s1knt6za9kkfw1e867");

    await _notificationService.showNotification(
      flp,
      _restaurantData.restaurantDetail,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
