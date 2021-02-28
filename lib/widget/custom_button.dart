import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String text;
  Function onTab;
  CustomButton({this.text,this.onTab});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab
      ,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff00A5FF),
              Color(0xff58C5FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
