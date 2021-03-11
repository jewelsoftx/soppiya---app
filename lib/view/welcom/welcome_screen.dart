import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shoppiya_admin/controller/auth_controller.dart';
import 'package:shoppiya_admin/utils/style.dart';
import 'package:shoppiya_admin/widget/custom_button.dart';
import 'package:shoppiya_admin/widget/custom_loader.dart';
import 'package:shoppiya_admin/widget/custom_text_field.dart';
import 'package:shoppiya_admin/widget/regular_text.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AuthController controller = Get.put(AuthController());

  int _pageState = 0;
  bool showLogin = false;
  bool isShowPassword = false;

  // ........... indicator ..............//
  bool showFirstIndicator = true;
  double totalIndicatorWidth = Get.width * .4;
  double halfIndicatorWidth = Get.width * .2;

  // ........... login container ..............//
  double containerHeight = Get.height * .10;
  double containerWidth = Get.width * .35;
  double containerMargin = 0.0;

  //............ start container .............//
  BoxDecoration _boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(100.0),
      topRight: Radius.circular(100.0),
    ),
  );

  // check box
  bool _checkBoxValue = false;

  // logo space from top
  double logoHeight = Get.height * .42;

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
        containerHeight = Get.height * .46;
        containerWidth = size.width;
        containerMargin = Get.height * .015;
        showLogin = true;
        logoHeight = Get.height * .32;
        // box decoration
        _boxDecoration = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));
        break;
      case 2:
        // SIGN UP
        containerHeight = Get.height * .42;
        isShowPassword = true;
        containerMargin = Get.height * .015;
        break;

      case 3:
        //FORGOT
        containerMargin = Get.height * .015;
        containerHeight = Get.height * .3;
        isShowPassword = false;
        break;
    }

    return Obx(() => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            backgroundColor: Style.backgroundColor,
            body: Stack(
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  top: logoHeight,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                      ),
                      SizedBox(height: Get.height * .04),
                      Text(
                        "Welcome to Soppiya!",
                        style: TextStyle(
                            color: Style.logoTextColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            fontSize: 24),
                      ),
                      Text(
                        "Make your eCommerce easy and fun!",
                        style: TextStyle(color: Style.deSelectedTextColor, fontFamily: "Montserrat", fontSize: 14),
                      )
                    ],
                  ),
                ),
                startButtonAlign(size),
              ],
            ),
          ),
        ));
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
          curve: Curves.easeOut,
          margin: EdgeInsets.all(containerMargin),
          duration: Duration(milliseconds: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showLogin == false ? startButton() : Visibility(visible: false, child: Text("")),
              if (showLogin == false)
                Visibility(visible: false, child: Text(""))
              else
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: ListView(
                            children: [
                              _pageState == 3
                                  ? Visibility(visible: false, child: indicatorWithText())
                                  : indicatorWithText(),
                              SizedBox(height: Get.height * 0.02),

                              Obx(
                                () => CustomTextField(
                                  controller: controller.emailTextController,
                                  hints: "Enter your email",
                                  isError: controller.isEmailError.value,
                                  errorText: controller.emailErrorText.value,
                                ),
                              ),

                              (_pageState == 2)
                                  ? Padding(
                                      padding: EdgeInsets.only(top: Get.height * 0.03),
                                      child: CustomTextField(
                                        controller: controller.referralTextController,
                                        hints: "Referral code (optional)",
                                        isError: false,
                                      ),
                                    )
                                  : (_pageState == 3)
                                      ? Visibility(
                                          visible: false,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Obx(
                                              () => SizedBox(),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Obx(
                                            () => CustomTextField(
                                              controller: controller.passwordTextController,
                                              hints: "Enter your password",
                                              isError: controller.isPasswordError.value,
                                              errorText: controller.passwordErrorText.value,

                                            ),
                                          ),
                                        ),

                              // remember me
                              (_pageState == 2)
                                  ? Visibility(visible: false, child: rememberMeColumn())
                                  : (_pageState == 3)
                                      ? Visibility(visible: false, child: rememberMeColumn())
                                      : rememberMeColumn(),

                              SizedBox(height: Get.height * 0.02),

                              // api error message
                              Obx(
                                // ignore: unrelated_type_equality_checks
                                () => controller.isShowApiMessage == false
                                    ? SizedBox()
                                    : Container(
                                        margin: EdgeInsets.only(top: 15, bottom: 10),
                                        child: Text(
                                          "${controller.loginMessage}",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                              ),
                              // login button
                              (_pageState == 2)
                                  ? CustomButton(
                                      text: 'Send Verification Code'.toUpperCase(),
                                      onTab: () {
                                        controller.doSignUp();
                                      },
                                    )
                                  : (_pageState == 3)
                                      ? CustomButton(
                                          text: 'Send reset link'.toUpperCase(),
                                          onTab: () {
                                            controller.doReset();
                                          },
                                        )
                                      : CustomButton(
                                          text: 'LOGIN',
                                          onTab: () {
                                            controller.doLoginApiCall();
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
                                          controller.isShowApiMessage.value = false;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RegularText(text: "Already have an account?"),
                                          RegularText(
                                            text: " Sign in instead",
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
                                              controller.isShowApiMessage.value = false;
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
                                              controller.isShowApiMessage.value = false;
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

  // start button

  Padding startButton() => Padding(
      padding: EdgeInsets.only(top: Get.height * .05),
      child: Center(
        child: Text(
          "Start",
          style: TextStyle(fontSize: 16, fontFamily: "Montserrat", fontWeight: FontWeight.w700),
        ),
      ));

  // remember me
  rememberMeColumn() {
    return Wrap(
      direction: Axis.vertical,
      children: [
        SizedBox(height: Get.height * 0.03),
        Row(
          children: [
            SizedBox(width: Get.width * 0.01),
            Row(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                  width: Get.height * 0.02,
                  child: Checkbox(
                      value: _checkBoxValue,
                      onChanged: (value) {
                        setState(() {
                          _checkBoxValue = value;
                        });
                      }),
                ),
                SizedBox(width: Get.height * 0.02),
                RegularText(text: 'Remember Me')
              ],
            ),
            SizedBox(width: Get.width * 0.1),
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

  indicatorWithText() {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        children: [
          //   SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Style.deSelectIndicatorColor,
                height: 3,
                width: totalIndicatorWidth,
              ),
              Container(
                height: 10,
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
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showFirstIndicator = true;
                    _pageState = 1;
                    controller.isShowApiMessage.value = false;
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
                      controller.isShowApiMessage.value = false;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.06),
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
      ),
    );
  }
}
