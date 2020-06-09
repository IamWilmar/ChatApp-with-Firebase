import 'package:flutter/material.dart';

class UserLogInfo with ChangeNotifier {
  String _username;
  String _email;
  String _password;

  String get username => _username;

  set username(String username) {
    this._username = username;
    notifyListeners();
  }

  String get email => _email;

  set email(String email) {
    this._email = email;
    notifyListeners();
  }

  String get password => _password;

  set password(String password) {
    this._password = password;
    notifyListeners();
  }
}
