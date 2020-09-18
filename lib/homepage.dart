import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './ClockView.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  bool _value = false;
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var timeZone =
        '${now.timeZoneName} ${now.timeZoneOffset.toString().split('.')[0]}';
    var analogClock = DateFormat('HH:mm').format(DateTime.now());
    var dateAndDay = DateFormat('EEEE, d MMM').format(now);
    return Scaffold(
      backgroundColor: _value ? Colors.white70 : Color(0xFF35425E),
      body: SafeArea(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFirstColumn(
                      imageUrl: 'assets/clock_icon.png', title: 'Clock'),
                  SizedBox(
                    height: 40,
                  ),
                  _buildFirstColumn(
                      imageUrl: 'assets/alarm_icon.png', title: 'Alarm'),
                  SizedBox(
                    height: 40,
                  ),
                  _buildFirstColumn(
                      imageUrl: 'assets/timer_icon.png', title: 'Timer'),
                  SizedBox(
                    height: 40,
                  ),
                  _buildFirstColumn(
                      imageUrl: 'assets/stopwatch_icon.png', title: 'Counter'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VerticalDivider(
                color: Colors.white54,
                thickness: 2,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Clock',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      analogClock,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      dateAndDay,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClockView(),
                    Text(
                      'Timezone',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          timeZone,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.white54,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'switch theme',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Switch(
                          activeTrackColor: Colors.orange[300],
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = !_value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFirstColumn({String imageUrl, String title}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Colors.grey,
      onTap: () {},
      child: Column(
        children: [
          Image.asset(
            imageUrl,
            scale: 1.8,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
