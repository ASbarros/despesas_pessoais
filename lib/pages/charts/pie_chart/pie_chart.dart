import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_drawer/my_drawer.dart';

import '../../../providers/chart_pie_provider.dart';
import 'samples/pie_chart_page.dart';

class ChartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<ChartPieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráficos'),
        actions: [
          IconButton(
              icon: Icon(chartProvider.visible
                  ? FontAwesomeIcons.solidEye
                  : FontAwesomeIcons.solidEyeSlash),
              onPressed: () {
                chartProvider.visible = !chartProvider.visible;
              }),
        ],
      ),
      drawer: MyDrawer(),
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
