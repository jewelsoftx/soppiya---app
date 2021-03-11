import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  int widgetPosition = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          widgetPosition==1? Text(
            "1st widget",
            style: TextStyle(fontSize: 30),
          ):
          Text(
            "2nd widget",
            style: TextStyle(fontSize: 30),
          ),

          widgetPosition==1?
          Text(
            "2nd widget",
            style: TextStyle(fontSize: 30),
          ):Text(
            "1st widget",
            style: TextStyle(fontSize: 30),
          ),

          RaisedButton(onPressed: (){

            setState(() {
              widgetPosition = 2;
            });


          }),
        ],
      ),
    );
  }
}
