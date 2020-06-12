import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier{
  bool _isLoading = false;
  bool _searchLoading = false;

  bool get searchLoading => _searchLoading;

  set searchLoading(bool searchLoading) {
    this._searchLoading = searchLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }
}

