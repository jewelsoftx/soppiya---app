import 'package:flutter/material.dart';
import 'package:shoppiya_admin/utils/style.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(top: 16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Style.menuIconColor,
              size: 24,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
