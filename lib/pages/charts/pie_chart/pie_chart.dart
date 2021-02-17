import 'package:flutter/material.dart';

import 'samples/pie_chart_sample2.dart';

class ChartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráficos'),
      ),
      body: Container(
        color: const Color(0xffeceaeb),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 8),
              PieChartPage(),
            ],
          ),
        ),
      ),
    );
  }
}
