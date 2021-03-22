import 'package:flutter/material.dart';

import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Menu',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  Image.asset('assets/images/icone.png', fit: BoxFit.cover)
                      .image,
            ),
          ),
          DrawerTile(
            iconData: Icons.home,
            title: 'Início',
            page: 0,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home-page');
            },
          ),
          DrawerTile(
            iconData: Icons.list,
            title: 'Categorias',
            page: 1,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/category-page');
            },
          ),
          DrawerTile(
            iconData: Icons.pie_chart,
            title: 'Gráficos',
            page: 2,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/charts-page');
            },
          ),
        ],
      ),
    );
  }
}
