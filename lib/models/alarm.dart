import 'package:flutter/material.dart';

class AlarmInfo {
  DateTime alarmDateTime;
  String description;
  bool isActive;
  List<Color> colors;
  AlarmInfo(this.alarmDateTime, this.colors, {this.description, this.isActive});
}

List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), GradientColors.sky,
      description: 'office', isActive: false),
  AlarmInfo(DateTime.now().add(Duration(hours: 2)), GradientColors.sunset,
      description: 'flutter', isActive: true)
];

class GradientColors {
  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}
