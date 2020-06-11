import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:chat_app/src/pages/search_page.dart';
import 'package:chat_app/src/services/auth.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  static final String routeName = 'contacts';
  @override
  Widget build(BuildContext context) {
    //final isLoading = Provider.of<LoadingProvider>(context);
    return Scaffold(
      appBar: _appBarCharRoom(),
      body: Text('Hola mundo'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0A7BC2),
        child: Icon(Icons.search, size: 35.0),
        elevation: 10.0,
        onPressed: () {
          Navigator.pushNamed(context, SearchPage.routeName);
        },
      ),
    );
  }

  AppBar _appBarCharRoom() {
    return AppBar(
      title: Text('Willkommen', style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xFF0A7BC2),
      elevation: 5.0,
      actions: <Widget>[
        _LogOutButton(),
      ],
    );
  }
}

class _LogOutButton extends StatelessWidget {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.power_settings_new, color: Colors.white, size: 30.0),
      onPressed: () {
        _authMethods.signOut();
        Navigator.pushReplacementNamed(context, LogInPage.routeName);
      },
    );
  }
}
