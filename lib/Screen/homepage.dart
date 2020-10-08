import 'dart:async';
import 'package:clock_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ClockView.dart';
import 'Package:provider/provider.dart';
import 'alarm.dart';

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
    final double size = MediaQuery.of(context).size.height;
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
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuData
                    .map((e) => _buildFirstColumn(e, context))
                    .toList()),
            VerticalDivider(
              color: Colors.white54,
              thickness: 1,
            ),
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (context, menu, _) {
                  if (menu.menu == MenuType.clock) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Clock',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                analogClock,
                                style: TextStyle(
                                    fontSize: 38,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                dateAndDay,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: ClockView(
                                  size: size * 0.35,
                                ))),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Timezone',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.white54,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Theme',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Switch(
                                    activeTrackColor: Colors.grey,
                                    value: _value,
                                    onChanged: (value) {
                                      _value = !_value;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (menu.menu == MenuType.Alarm) {
                    return AlarmPage();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFirstColumn(MenuInfo _menu, BuildContext context) {
  return Consumer<MenuInfo>(
    builder: (context, menu, child) => FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      padding: EdgeInsets.all(16.0),
      onPressed: () {
        var prov = Provider.of<MenuInfo>(context, listen: false);
        prov.update(_menu);
      },
      color: _menu.menu == menu.menu ? Colors.grey : Colors.transparent,
      child: Column(
        children: [
          Image.asset(
            _menu.imageUrl,
            scale: 1.8,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            _menu.title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
