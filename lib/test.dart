import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  double height = 40.0;

  BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.only(
      topLeft: const Radius.circular(100.0),
      topRight: const Radius.circular(100.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height,
            width: 40,
            decoration: boxDecoration,
          ),
          RaisedButton(onPressed: () {
            setState(() {
              height = 100.0;
            });
          })
        ],
      ),
    );
  }
}
