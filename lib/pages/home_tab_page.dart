import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key, required this.name});
 final String name;

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  @override
  Widget build(BuildContext context) {
    return Container (
      height: 20,
        child: Text(widget.name),
      )
    ;
  }
}