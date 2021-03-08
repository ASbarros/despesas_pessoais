import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  PageProvider(/* this._pageController */);
  //final PageController _pageController;
  int page = 0;
  void setPage(int page) {
    if (page == this.page) return;
    this.page = page;
    //_pageController.jumpToPage(page);
  }
}
