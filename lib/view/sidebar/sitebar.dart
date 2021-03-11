import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/controller/main_screen_controller.dart';
import 'package:shoppiya_admin/main.dart';
import 'package:shoppiya_admin/utils/style.dart';
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
                  padding: EdgeInsets.all(10),
                  color: Style.menuBgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: Get.height * 0.04),
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Style.white,
                            ),
                            radius: 30,
                          ),
                          SizedBox(width: Get.width * .05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(color: Style.white, fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                "${loginModel.businessData.email}",
                                style: TextStyle(
                                  color: Style.white,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Divider(
                        thickness: 0.5,
                        color: Style.white.withOpacity(0.3),
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          mainScreenController.onIconPressed();
                          mainScreenController.selectedItemTitle.value = "Home";
                        },
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "My Account",
                        onTap: () {
                          mainScreenController.onIconPressed();
                          mainScreenController.selectedItemTitle.value = "My Account";
                        },
                      ),
                      MenuItem(
                        icon: Icons.shopping_basket,
                        title: "My Orders",
                        onTap: () {
                          mainScreenController.onIconPressed();
                          mainScreenController.selectedItemTitle.value = "My Orders";
                        },
                      ),
                      MenuItem(icon: Icons.card_giftcard, title: "Wishlist"),
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
                      color: Style.menuBgColor,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: mainScreenController.animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Style.white,
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
    paint.color = Style.white;

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
