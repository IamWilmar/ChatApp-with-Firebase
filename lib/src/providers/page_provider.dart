import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier{
  String _actualRoute = LogInPage.routeName;

  String get actualRoute => _actualRoute;

  set actualRoute(String actualRoute) {
    this._actualRoute = actualRoute;
    print(actualRoute);
    notifyListeners();
  }
}