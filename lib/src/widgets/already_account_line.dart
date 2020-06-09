import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:chat_app/src/pages/registration_page.dart';
import 'package:chat_app/src/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlreadyAccount extends StatelessWidget {
  final String text1;
  final String text2;
  const AlreadyAccount({@required this.text1, @required this.text2});
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text1, style: TextStyle(color: Colors.white)),
          SizedBox(width: 10.0),
          GestureDetector(
            onTap: () {
              if (pageProvider.actualRoute == RegisterPage.routeName) {
                pageProvider.actualRoute = LogInPage.routeName;
                Navigator.of(context).pushReplacementNamed(LogInPage.routeName);
              } else {
                pageProvider.actualRoute = RegisterPage.routeName;
                Navigator.of(context)
                    .pushReplacementNamed(RegisterPage.routeName);
              }
            },
            child: Text(
              text2,
              style: TextStyle(
                  color: Colors.white, decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}
