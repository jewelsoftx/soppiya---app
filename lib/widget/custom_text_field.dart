import 'package:flutter/material.dart';
import 'package:shoppiya_admin/utils/style.dart';

class CustomTextField extends StatelessWidget {
  String hints;
  CustomTextField({
    Key key,
    this.hints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Style.textFieldColor, fontSize: 14),
      cursorColor: Style.textFieldColor,
      decoration: InputDecoration(
        isDense: true,
        hintText: "$hints",
        hintStyle: TextStyle(color: Style.textFieldColor,fontFamily: "Montserrat"),
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