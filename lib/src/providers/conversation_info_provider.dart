import 'package:flutter/material.dart';

class ChatInfoProvider with ChangeNotifier{
 String _chatName;
 String _chatId;
 String _message;
 bool  _isSent = false;

  bool get isSent => _isSent;

  set isSent(bool isSent) {
    this._isSent = isSent;
    notifyListeners();
  }

  String get message => _message;

  set message(String message) {
    this._message = message;
    notifyListeners();
  }

  String get chatId => _chatId;

  set chatId(String chatId) {
    this._chatId = chatId;
    notifyListeners();
  }
  String get chatName => _chatName;

  set chatName(String chatName) {
    this._chatName = chatName;
    notifyListeners();
  } 
}