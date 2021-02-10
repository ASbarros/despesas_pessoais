import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function() onTap;

  const DrawerTile({this.iconData, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(iconData, size: 32, color: primaryColor),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
