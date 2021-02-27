import 'package:flutter/material.dart';
import 'package:shoppiya_admin/utils/style.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  int _pageState = 0;
  bool showLogin = false;
  bool isShowPassword = false;
  double loginHeight = 600;

  // ........... indicator ..............//
  bool showFirstIndicator = true;
  double totalIndicatorWidth = 150;
  double halfIndicatorWidth = 75;

  // ........... login container ..............//
  double containerHeight = 80.0;
  double containerWidth = 150.0;
  double containerMargin = 0.0;

  BoxDecoration _boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(100.0),
      topRight: Radius.circular(100.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    switch (_pageState) {
      case 0:
        showLogin = false;
        break;
      case 1:
        containerHeight = 400.0;
        containerWidth = size.width;
        containerMargin = 10.0;
        showLogin = true;
        // box decoration
        _boxDecoration = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));
        break;
      case 2:
        loginHeight = 350;
        isShowPassword = true;

        break;
    }

    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Stack(
        children: [startButtonAlign(size)],
      ),
    );
  }

  Align startButtonAlign(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _pageState = 1;
          });
        },
        child: AnimatedContainer(
          width: containerWidth,
          height: containerHeight,
          decoration: _boxDecoration,
          margin: EdgeInsets.all(containerMargin),
          duration: Duration(milliseconds: 180),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showLogin == false
                  ? Padding(padding: EdgeInsets.only(top: 40), child: Text("Start"))
                  : Visibility(visible: false, child: Text("")),
              if (showLogin == false)
                Visibility(visible: false, child: Text(""))
              else
                Column(
                  children: [
                    // indicator
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: Style.deSelectIndicatorColor,
                              height: 3,
                              width: totalIndicatorWidth,
                            ),
                            Container(
                              color: Colors.transparent,
                              height: 20,
                              width: totalIndicatorWidth,
                              child: Row(
                                children: [
                                  showFirstIndicator == true
                                      ? Container(
                                          height: 3,
                                          width: halfIndicatorWidth,
                                          color: Color(0xff00A5FF),
                                        )
                                      : Visibility(
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          visible: false,
                                          child: Container(
                                            height: 3,
                                            width: halfIndicatorWidth,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                  showFirstIndicator == false
                                      ? Container(
                                          height: 3,
                                          width: halfIndicatorWidth,
                                          color: Color(0xff00A5FF),
                                        )
                                      : Visibility(
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          visible: false,
                                          child: Container(
                                            height: 3,
                                            width: halfIndicatorWidth,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                showFirstIndicator = true;
                              });
                            },
                            child: Text("Sign Up")),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                showFirstIndicator = false;
                              });
                            },
                            child: Text("Sign Up")),
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
