import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:financas_pessoais/pages/charts/chart_line/chart_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/custom_drawer/my_drawer.dart';

import '../../providers/chart_pie_provider.dart';
import 'pie_chart/pie_chart_page.dart';

class ChartsPage extends StatefulWidget {
  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  int _pageSelected = 0;

  final _pages = [
    Container(
      color: const Color(0xffeceaeb),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 8),
            PieChartPage(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
    Container(
      color: const Color(0xffeceaeb),
      child: MyLineChart(),
    )
  ];

  void _setPage(int index) {
    setState(() {
      _pageSelected = index;
    });
  }

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
      body: _pages[_pageSelected],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xffeceaeb),
        items: <Widget>[
          Icon(FontAwesomeIcons.chartPie),
          Icon(FontAwesomeIcons.chartLine)
        ],
        onTap: (index) {
          _setPage(index);
        },
      ),
    );
  }
}
