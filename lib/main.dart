import 'package:chat_app/src/pages/contacts_page.dart';
import 'package:chat_app/src/pages/conversation_page.dart';
import 'package:chat_app/src/pages/loading_page.dart';
import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:chat_app/src/pages/registration_page.dart';
import 'package:chat_app/src/pages/search_page.dart';
import 'package:chat_app/src/pages/test_page.dart';
import 'package:chat_app/src/providers/conversation_info_provider.dart';
import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:chat_app/src/providers/page_provider.dart';
import 'package:chat_app/src/providers/query_search_provider.dart';
import 'package:chat_app/src/providers/right_info_provider.dart';
import 'package:chat_app/src/providers/search_provider.dart';
import 'package:chat_app/src/providers/user_data.dart';
import 'package:chat_app/src/shared/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferenciasUsuario prefs = PreferenciasUsuario();
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
        ChangeNotifierProvider(
          create: (_) => RightLogProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchQueryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatInfoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NearBy',
        initialRoute: prefs.isUserLogged == false ? LogInPage.routeName : ContactsPage.routeName,
        routes: {
          RegisterPage.routeName: (BuildContext context) => RegisterPage(),
          LogInPage.routeName: (BuildContext context) => LogInPage(),
          TestPage.routeName: (BuildContext context) => TestPage(),
          LoadingPage.routeName: (BuildContext context) => LoadingPage(),
          ContactsPage.routeName: (BuildContext context) => ContactsPage(),
          SearchPage.routeName: (BuildContext context) => SearchPage(),
          ConversationPage.routeName: (BuildContext context) =>
              ConversationPage(),
        },
      ),
    );
  }
}
