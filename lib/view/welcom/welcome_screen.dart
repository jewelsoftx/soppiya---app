import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/utils/style.dart';
import 'package:shoppiya_admin/widget/custom_button.dart';
import 'package:shoppiya_admin/widget/custom_text_field.dart';
import 'package:shoppiya_admin/widget/regular_text.dart';

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

  // check box
  bool _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    switch (_pageState) {
      case 0:
        // HOME
        showLogin = false;
        break;
      case 1:
        // LOGIN
        containerHeight = 350.0;
        containerWidth = size.width;
        containerMargin = 20.0;
        showLogin = true;
        // box decoration
        _boxDecoration = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));
        break;
      case 2:
        // SIGN UP
        containerHeight = 260;
        isShowPassword = true;
        containerMargin = 20.0;
        break;

      case 3:
        //FORGOT
        containerMargin = 20.0;
        containerHeight = 180;
        isShowPassword = false;
        break;
    }

    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Stack(
        children: [
          startButtonAlign(size)

        ],
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
          curve: Curves.easeInOutQuad,
          margin: EdgeInsets.all(containerMargin),
          duration: Duration(milliseconds: 800),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showLogin == false
                  ? Padding(padding: EdgeInsets.only(top: 40), child: Text("Start"))
                  : Visibility(visible: false, child: Text("")),
              if (showLogin == false)
                Visibility(visible: false, child: Text(""))
              else
                Expanded(
                  child: Column(
                    children: [
                      _pageState == 3 ? Visibility(visible: false, child: indicatorWithText()) : indicatorWithText(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: ListView(
                            children: [
                              CustomTextField(
                                hints: "Enter your email",
                              ),
                              (_pageState == 2)
                                  ? Visibility(
                                      visible: false,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: CustomTextField(
                                          hints: "Enter your password",
                                        ),
                                      ),
                                    )
                                  : (_pageState == 3)
                                      ? Visibility(
                                          visible: false,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: CustomTextField(
                                              hints: "Enter your password",
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: CustomTextField(
                                            hints: "Enter your password",
                                          ),
                                        ),

                              // remember me
                              (_pageState == 2)
                                  ? Visibility(visible: false, child: rememberMeColumn())
                                  : (_pageState == 3)
                                      ? Visibility(visible: false, child: rememberMeColumn())
                                      : rememberMeColumn(),

                              SizedBox(height: 20),
                              // login button

                              (_pageState == 2)
                                  ? CustomButton(
                                      text: 'Send Verification Code'.toUpperCase(),
                                      onTab: () {
                                        Get.snackbar("Clicked", 'Verification clicked');
                                      },
                                    )
                                  : (_pageState == 3)
                                      ? CustomButton(
                                          text: 'Send reset link'.toUpperCase(),
                                          onTab: () {
                                            Get.snackbar("Clicked", 'resend clicked');
                                          },
                                        )
                                      : CustomButton(
                                          text: 'LOGIN',
                                          onTab: () {
                                            Get.snackbar("Clicked", 'login clicked');
                                          },
                                        ),

                              // new user text
                              SizedBox(height: 20),
                              (_pageState == 2)
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _pageState = 1;
                                          showFirstIndicator = true;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RegularText(text: "Already have an account?"),
                                          RegularText(
                                            text: "Sign in instead",
                                            color: Color(0xff00A5FF),
                                          ),
                                        ],
                                      ),
                                    )
                                  : (_pageState == 3)
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _pageState = 1;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.chevron_left,
                                                color: Color(0xff00A5FF),
                                              ),
                                              RegularText(
                                                text: "Sign in instead",
                                                color: Color(0xff00A5FF),
                                              ),
                                            ],
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _pageState = 2;
                                              showFirstIndicator = false;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              RegularText(text: "New on our platform?"),
                                              RegularText(
                                                text: " Create an account",
                                                color: Color(0xff00A5FF),
                                              ),
                                            ],
                                          ),
                                        )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Column rememberMeColumn() {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Checkbox(
                      value: _checkBoxValue,
                      onChanged: (value) {
                        setState(() {
                          _checkBoxValue = value;
                        });
                      }),
                ),
                SizedBox(width: 10),
                RegularText(text: 'Remember Me')
              ],
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _pageState = 3;
                  });
                },
                child: RegularText(text: 'Forgot Password?'))
          ],
        )
      ],
    );
  }

  Column indicatorWithText() {
    return Column(
      children: [
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
                  _pageState = 1;
                });
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: showFirstIndicator == true ? Style.selectedTextColor : Style.deSelectedTextColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
                onTap: () {
                  setState(() {
                    showFirstIndicator = false;
                    _pageState = 2;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: showFirstIndicator == false ? Style.selectedTextColor : Style.deSelectedTextColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
