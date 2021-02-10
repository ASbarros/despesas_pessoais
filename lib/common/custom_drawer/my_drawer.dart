import 'package:flutter/material.dart';

import '../../pages/category/category_page.dart';
import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Menu',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  Image.asset('assets/images/waiting.png', fit: BoxFit.cover)
                      .image,
            ),
          ),
          DrawerTile(
            iconData: Icons.home,
            title: "Início",
          ),
          DrawerTile(
            iconData: Icons.list,
            title: "Categorias",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CategoryPage(),
                ),
              );
            },
          ),
          DrawerTile(
            iconData: Icons.check,
            title: "Sobre",
          ),
        ],
      ),
    );
  }
}
