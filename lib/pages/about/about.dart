import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
        centerTitle: true,
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.headline6,
              children: <TextSpan>[
                TextSpan(text: 'It\'s\n '),
                TextSpan(
                    text: 'all \n',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        backgroundColor: Colors.black)),
                TextSpan(text: 'widgets '),
              ]),
        ),
      ),
    );
  }
}
