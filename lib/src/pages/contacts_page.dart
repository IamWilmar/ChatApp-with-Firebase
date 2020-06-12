import 'package:chat_app/src/pages/conversation_page.dart';
import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:chat_app/src/pages/search_page.dart';
import 'package:chat_app/src/providers/conversation_info_provider.dart';
import 'package:chat_app/src/services/auth.dart';
import 'package:chat_app/src/services/database.dart';
import 'package:chat_app/src/shared/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatelessWidget {
  static final String routeName = 'contacts';
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  final AuthMethods auth = AuthMethods();
  @override
  Widget build(BuildContext context) {
    final DataBaseMethods db = DataBaseMethods();
    if (prefs.isUserLogged == false) {
      auth
          .signInEmailAndPassword(prefs.userEmail, prefs.userPassword)
          .then((value) => {prefs.isUserLogged = true});
    }
    Stream<QuerySnapshot> contacts = db.getChatRooms(prefs.userName);
    return Scaffold(
      appBar: _appBarCharRoom(),
      body: contacts == null
          ? Container()
          : StreamBuilder(
              stream: contacts,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContactsTile(
                        title: snapshot.data.documents[index].data['chatRoomId']
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(prefs.userName, ""),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
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

class ContactsTile extends StatelessWidget {
  final String title;
  final String chatId;
  const ContactsTile({this.title, this.chatId});
  @override
  Widget build(BuildContext context) {
    final chatInfo = Provider.of<ChatInfoProvider>(context);
    final PreferenciasUsuario prefs = PreferenciasUsuario();
    return ListTile(
      onTap: () {
        chatInfo.chatName = title;
        chatInfo.chatId = getchatRoomId(title, prefs.userName);
        Navigator.pushNamed(context, ConversationPage.routeName);
      },
      leading: CircleAvatar(
        child: Text(title.substring(0, 1).toUpperCase()),
      ),
      title: Text(title),
    );
  }

  getchatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

class _LogOutButton extends StatelessWidget {
  final AuthMethods _authMethods = AuthMethods();
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.power_settings_new, color: Colors.white, size: 30.0),
      onPressed: () {
        prefs.isUserLogged = false;
        _authMethods.signOut();
        Navigator.pushReplacementNamed(context, LogInPage.routeName);
      },
    );
  }
}
