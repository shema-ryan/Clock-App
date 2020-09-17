import 'package:flutter/material.dart';

import './ClockView.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _value ? Colors.white70 : Color(0xFF35425E),
      body: SafeArea(
        child: Column(
          children: [
            Switch(
              activeTrackColor: Colors.orange[300],
              value: _value,
              onChanged: (value) {
                _value = !_value;
                setState(() {});
              },
            ),
            ClockView(),
          ],
        ),
      ),
    );
  }
}
