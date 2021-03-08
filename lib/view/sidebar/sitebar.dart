import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shoppiya_admin/controller/main_screen_controller.dart';
import 'package:shoppiya_admin/view/sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  var mainScreenController = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: mainScreenController.isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: mainScreenController.animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xff95AFC0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          "Prateek",
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "tonujewel@gmail.com",
                          style: TextStyle(
                            color: Color(0xff95AFC0),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          mainScreenController.onIconPressed();

                          //   BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "My Account",
                        onTap: () {
                          mainScreenController.onIconPressed();
                          mainScreenController.selectedItemTitle.value = "My Account";
                          // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.shopping_basket,
                        title: "My Orders",
                        onTap: () {
                          mainScreenController.onIconPressed();
                          mainScreenController.selectedItemTitle.value = "My Orders";

                          //  BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.card_giftcard,
                        title: "Wishlist",
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    mainScreenController.onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xff95AFC0),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: mainScreenController.animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
