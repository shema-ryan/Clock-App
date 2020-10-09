import 'package:clock_app/models/alarm.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
                fontFamily: 'avenir',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: alarms.map<Widget>((clock) {
              final String alarmTime =
                  DateFormat.Hm().format(clock.alarmDateTime);
              return Container(
                margin: EdgeInsets.only(bottom: 15.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: clock.colors.last.withOpacity(0.4),
                        blurRadius: 5.0,
                        offset: Offset(3, 3),
                        spreadRadius: 2),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: clock.colors,
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.label,
                              color: Colors.white70,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              clock.description,
                              style: TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Switch(value: clock.isActive, onChanged: (value) {}),
                      ],
                    ),
                    Text(
                      'Mon - Fri',
                      style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$alarmTime Am',
                          style: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          color: Colors.white70,
                          icon: Icon(Icons.expand_more),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).followedBy([
              alarms.length < 5
                  ? DottedBorder(
                      color: Colors.grey,
                      borderType: BorderType.RRect,
                      strokeWidth: 2,
                      dashPattern: [10, 3],
                      radius: Radius.circular(15.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(20.0),
                          onPressed: () {
                            scheduleNotification();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/add_alarm.png',
                                scale: 1.5,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Add alarm',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 19,
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text('only five alarms allowed '),
            ]).toList(),
          ),
        ],
      ),
    );
  }
}

Future<void> scheduleNotification() async {
  tz.initializeTimeZones();
  var scheduleNotificationDateTime =
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notify', 'alarm_notify', 'Channel for alarm notifications',
      icon: 'aaa',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'));
  var iosPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics);
  flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'office',
      'Good morning office time',
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
}
