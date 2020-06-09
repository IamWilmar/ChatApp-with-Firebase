import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier{
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }
}

