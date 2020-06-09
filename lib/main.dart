import 'package:chat_app/src/pages/loading_page.dart';
import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:chat_app/src/pages/registration_page.dart';
import 'package:chat_app/src/pages/test_page.dart';
import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:chat_app/src/providers/page_provider.dart';
import 'package:chat_app/src/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserLogInfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoadingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NearBy',
        initialRoute: LogInPage.routeName,
        routes: {
          RegisterPage.routeName  : (BuildContext context) => RegisterPage(),
          LogInPage.routeName     : (BuildContext context) => LogInPage(),
          TestPage.routeName      : (BuildContext context) => TestPage(),
          LoadingPage.routeName   : (BuildContext context) => LoadingPage(),
        },
      ),
    );
  }
}
