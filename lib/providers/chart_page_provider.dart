import 'package:flutter/material.dart';

class ChartPageProvider with ChangeNotifier {
  bool _visible = true;
  set visible(bool value) {
    _visible = value;
    notifyListeners();
  }

  bool get visible => _visible;
}
