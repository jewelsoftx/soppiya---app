import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/controller/main_screen_controller.dart';
import 'package:shoppiya_admin/view/sidebar/sitebar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => Center(child: Text("${controller.selectedItemTitle}"))),
          SideBar(),
        ],
      ),
    );
  }
}
