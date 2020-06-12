import 'package:flutter/material.dart';

class ChatInfoProvider with ChangeNotifier{
 String _chatName;

  String get chatName => _chatName;

  set chatName(String chatName) {
    this._chatName = chatName;
  } 
}