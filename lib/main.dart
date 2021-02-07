import 'package:flutter/material.dart';

import 'components/transaction_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.add), onPressed: null)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            child: Card(
              color: Colors.blue,
              elevation: 5,
            ),
          ),
          TransactionUser()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
      ),
    );
  }
}
