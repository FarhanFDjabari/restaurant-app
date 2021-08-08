import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/cubit/notification/notification_cubit.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50)),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                ),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
              top: 70.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Settings',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ListView(
                      children: [
                        BlocProvider<NotificationCubit>(
                          create: (context) => NotificationCubit(),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            tileColor: Colors.grey.withOpacity(0.1),
                            title: Text(
                              'Notifikasi Terjadwal',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            trailing: BlocConsumer<NotificationCubit,
                                NotificationState>(
                              listener: (context, state) {
                                if (state is NotificationError) {
                                  Get.showSnackbar(GetBar(
                                    message: state.errorMessage,
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 15,
                                  ));
                                } else if (state is NotificationSuccess) {
                                  Get.showSnackbar(GetBar(
                                    message: state.value
                                        ? 'Activate Scheduled Notification'
                                        : 'Deactivate Scheduled Notification',
                                    margin: EdgeInsets.all(10),
                                    duration: Duration(seconds: 4),
                                    borderRadius: 15,
                                  ));
                                }
                              },
                              builder: (context, state) {
                                return Switch.adaptive(
                                  value: context
                                      .read<NotificationCubit>()
                                      .getIsSchedule(),
                                  onChanged: (value) async {
                                    if (Platform.isIOS) {
                                    } else {
                                      context
                                          .read<NotificationCubit>()
                                          .scheduleNotification(value);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
