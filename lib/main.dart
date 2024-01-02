import 'package:flutter/material.dart';

// import 'model/common_model.dart';
import 'navigator/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter toutiao',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}
