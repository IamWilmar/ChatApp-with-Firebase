import 'package:chat_app/src/providers/query_search_provider.dart';
import 'package:chat_app/src/providers/search_provider.dart';
import 'package:chat_app/src/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static final String routeName = 'search';
  final DataBaseMethods db = DataBaseMethods();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchUser = Provider.of<SearchProvider>(context);
    final searchQuery = Provider.of<SearchQueryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A7BC2),
        actions: <Widget>[
          Container(width: size.width * 0.2),
          Expanded(child: _SearchField()),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
                db.getUsernameSearch(searchUser.search).then((val) {
                  print(val.toString());
                  searchQuery.searchQuery = val;
                });
            },
          ),
        ],
      ),
      body: Container(
        height: size.height * 0.12,
        child: searchQuery.searchQuery == null
            ? Container()
            : ListView.builder(
                itemCount: searchQuery.searchQuery.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return _SearchTile(
                    username: searchQuery.searchQuery.documents[index].data['name'],
                    email:    searchQuery.searchQuery.documents[index].data['email'],
                  );
                },
              ),
      ),
    );
  }
}

class _SearchTile extends StatelessWidget {
  final String username;
  final String email;
  _SearchTile({@required this.username, this.email});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(username),
      subtitle: Text(email),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.message, color: Color(0xFF0A7BC2), size: 30),
      ),
    );
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
