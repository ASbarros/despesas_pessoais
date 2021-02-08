import 'package:flutter/material.dart';

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
          ListTile(
              title: Text('Home', style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {}),
          ListTile(
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              title: Text('Categorias', style: TextStyle(fontSize: 20)),
              onTap: () {}),
          ListTile(
              title: Text('Sobre', style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.check),
              onTap: () {}),
        ],
      ),
    );
  }
}
