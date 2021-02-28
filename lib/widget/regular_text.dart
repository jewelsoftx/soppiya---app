import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {

  String text;
  Color color;

  RegularText({@required this.text,this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
        fontSize: 14,
        fontFamily: 'Montserrat',
        color:color==null? Color(0xff3E5570):color));
  }
}
