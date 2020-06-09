import 'package:chat_app/src/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TestPage extends StatelessWidget {
  static final String routeName = 'test';
  @override
  Widget build(BuildContext context) {
    final userLogInfo = Provider.of<UserLogInfo>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(userLogInfo.username),
            Text(userLogInfo.email),
            Text(userLogInfo.password),
          ],
        ),
     ),
   );
  }
}