import 'package:flutter/material.dart';

import '../../pages/category/category_page.dart';
import '../../pages/charts/pie_chart/pie_chart.dart';
import '../../pages/home_page.dart';
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
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => MyHomePage(),
                ),
              );
            },
          ),
          DrawerTile(
            iconData: Icons.list,
            title: 'Categorias',
            page: 1,
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
            iconData: Icons.pie_chart,
            title: 'Gráficos',
            page: 2,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ChartsPage(),
                ),
              );
            },
          ),
          /* DrawerTile(
            iconData: Icons.backup,
            title: 'Backup',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => BackupPage(),
                ),
              );
            },
          ), */
        ],
      ),
    );
  }
}
