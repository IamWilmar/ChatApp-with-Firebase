import 'package:chat_app/src/pages/conversation_page.dart';
import 'package:chat_app/src/providers/conversation_info_provider.dart';
import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:chat_app/src/providers/query_search_provider.dart';
import 'package:chat_app/src/providers/search_provider.dart';
import 'package:chat_app/src/services/database.dart';
import 'package:chat_app/src/shared/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static final String routeName = 'search';
  final DataBaseMethods db = DataBaseMethods();
  final PreferenciasUsuario prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchUser = Provider.of<SearchProvider>(context);
    final searchQuery = Provider.of<SearchQueryProvider>(context);
    final isLoading = Provider.of<LoadingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A7BC2),
        actions: <Widget>[
          Container(width: size.width * 0.2),
          Expanded(child: _SearchField()),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              isLoading.searchLoading = true;
              db.getUsernameSearch(searchUser.search).then((val) {
                print(val.toString());
                searchQuery.searchQuery = val;
                isLoading.searchLoading = false;
              });
            },
          ),
        ],
      ),
      body: _SearchList(
          size: size, searchQuery: searchQuery, isLoading: isLoading),
    );
  }
}

class _SearchList extends StatelessWidget {
  const _SearchList({
    Key key,
    @required this.size,
    @required this.searchQuery,
    @required this.isLoading,
  }) : super(key: key);

  final Size size;
  final SearchQueryProvider searchQuery;
  final LoadingProvider isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.12,
      child: searchQuery.searchQuery == null
          ? isLoading.searchLoading
              ? Center(child: CircularProgressIndicator())
              : Container()
          : isLoading.searchLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: searchQuery.searchQuery.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _SearchTile(
                      username:
                          searchQuery.searchQuery.documents[index].data['name'],
                      email: searchQuery
                          .searchQuery.documents[index].data['email'],
                    );
                  },
                ),
    );
  }
}

class _SearchTile extends StatelessWidget {
  final String username;
  final String email;
  _SearchTile({@required this.username, this.email});

  final DataBaseMethods db = DataBaseMethods();
  final PreferenciasUsuario prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final searchUser = Provider.of<SearchProvider>(context);
    final chatInfo = Provider.of<ChatInfoProvider>(context);

    createChatRoom(String userSearch) {
      List<String> users = [userSearch, prefs.userName];
      String roomName = getchatRoomId(users[0], users[1]);
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatRoomId': roomName,
      };
      DataBaseMethods().createChatRoom(roomName, chatRoomMap);
      Navigator.pushNamed(context, ConversationPage.routeName);
    }

    return searchUser.search == prefs.userName
        ? Container()
        : ListTile(
            title: Text(username),
            subtitle: Text(email),
            trailing: IconButton(
              onPressed: () {
                chatInfo.chatName = searchUser.search;
                chatInfo.chatId = getchatRoomId(searchUser.search, prefs.userName);
                createChatRoom(searchUser.search);
              },
              icon: Icon(Icons.message, color: Color(0xFF0A7BC2), size: 30),
            ),
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

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchNow = Provider.of<SearchProvider>(context);
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Username',
        hintStyle: TextStyle(
          color: Colors.white54,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
      ),
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      onChanged: (search) {
        searchNow.search = search;
      },
    );
  }
}
