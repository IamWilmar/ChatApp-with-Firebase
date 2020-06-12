import 'package:chat_app/src/providers/conversation_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatelessWidget {
  static final String routeName = 'conversation';
  @override
  Widget build(BuildContext context) {
    final chatInfo = Provider.of<ChatInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(chatInfo.chatName),
      ),
      body: Text('Hola mundo'),
    );
  }
}