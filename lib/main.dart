import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/cubit/notification/notification_cubit.dart';
import 'package:restaurant_app/theme/custom_theme.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/review_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/ui/splash_screen.dart';

final FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationCubit _notification = NotificationCubit();

  _notification.initBackgroundService();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  _notification.initNotification(flp);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        textTheme: customTextTheme,
        accentColor: Colors.amber,
        primaryColor: Colors.amber,
      ),
      routes: {
        '/': (context) => RestaurantListPage(),
        '/splash-screen': (context) => SplashScreen(),
        '/settings': (context) => SettingsPage(),
        '/search': (context) => SearchPage(),
        '/review': (context) => ReviewPage(),
        '/restaurant-detail': (context) => RestaurantDetailPage(),
      },
      initialRoute: '/splash-screen',
    );
  }
}
