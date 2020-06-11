import 'package:flutter/material.dart';

class RightLogProvider with ChangeNotifier{
  bool _isRight = true;

  bool get isRight => _isRight;

  set isRight(bool isRight) {
    this._isRight = isRight;
    notifyListeners();
  }
}