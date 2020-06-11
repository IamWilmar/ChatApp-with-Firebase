import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier{
  String _search = "";
  String get search => _search;

  set search(String search) {
    this._search = search;
    notifyListeners();
  }

}