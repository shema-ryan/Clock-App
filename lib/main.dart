import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screen/homepage.dart';
import 'models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuInfo>(
      create: (context) => MenuInfo(MenuType.clock),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clock-app',
        theme: ThemeData(
          fontFamily: 'avenir',
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Homepage(),
      ),
    );
  }
}
