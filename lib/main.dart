import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/category/category_page.dart';
import 'pages/charts/charts.dart';
import 'pages/home_page.dart';
import 'providers/category_provider.dart';
import 'providers/chart_pie_provider.dart';
import 'providers/chart_line_provider.dart';
import 'providers/expenses_provider.dart';
import 'providers/page_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExpensesProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ChartPieProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ChartLineProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                button: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/category-page':
              return MaterialPageRoute(builder: (_) => CategoryPage());
            case '/charts-page':
              return MaterialPageRoute(builder: (_) => ChartsPage());
            case '/home-page':
            case '/':
            default:
              return MaterialPageRoute(builder: (_) => MyHomePage());
          }
        },
      ),
    );
  }
}
