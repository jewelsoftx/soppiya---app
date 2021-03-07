import 'package:flutter/material.dart';
import 'package:shoppiya_admin/view/home.dart';
import 'package:shoppiya_admin/view/sidebar/sidebar2.dart';
import 'package:shoppiya_admin/view/sidebar/sitebar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          HomePage(),

          Sidebar2()

        ],
      ),
    );
  }
}
