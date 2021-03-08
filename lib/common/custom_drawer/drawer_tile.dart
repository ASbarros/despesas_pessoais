import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/page_provider.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function() onTap;
  final int page;

  const DrawerTile({this.iconData, this.onTap, this.title, this.page});

  @override
  Widget build(BuildContext context) {
    final curPage = context.watch<PageProvider>().page;
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        context.read<PageProvider>().setPage(page);
        onTap();
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(iconData,
                  size: 32,
                  color: curPage == page ? primaryColor : Colors.green),
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
