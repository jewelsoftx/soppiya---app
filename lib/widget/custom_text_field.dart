import 'package:flutter/material.dart';
import 'package:shoppiya_admin/utils/style.dart';

class CustomTextField extends StatelessWidget {
  String hints;
  bool isError = false;
  String errorText;

  String textChangeValue;
  TextEditingController controller;

  CustomTextField(
      {Key key, @required this.hints, @required this.controller, this.isError, this.errorText, this.textChangeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Style.textFieldColor, fontSize: 14),
      cursorColor: Style.textFieldColor,
      onChanged: (value) {
        textChangeValue = value;
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: "$hints",
        hintStyle: TextStyle(color: Style.textFieldColor, fontFamily: "Montserrat"),
        errorText: isError ? '$errorText' : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.textFieldColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.textFieldColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.textFieldColor),
        ),
      ),
    );
  }
}
