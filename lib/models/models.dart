import 'package:flutter/foundation.dart';

enum MenuType { clock, Alarm, Timer, Counter }

class MenuInfo extends ChangeNotifier {
  MenuType menu;
  String title;
  String imageUrl;
  MenuInfo(this.menu, {this.title, this.imageUrl});

  update(menuInfo) {
    this.menu = menuInfo.menu;
    notifyListeners();
  }
}

List<MenuInfo> menuData = [
  MenuInfo(MenuType.clock, title: 'Clock', imageUrl: 'assets/clock_icon.png'),
  MenuInfo(MenuType.Alarm, imageUrl: 'assets/alarm_icon.png', title: 'Alarm'),
  MenuInfo(MenuType.Timer, imageUrl: 'assets/timer_icon.png', title: 'Timer'),
  MenuInfo(MenuType.Counter,
      imageUrl: 'assets/stopwatch_icon.png', title: 'Counter'),
];
