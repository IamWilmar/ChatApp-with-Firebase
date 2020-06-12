import 'package:chat_app/src/providers/conversation_info_provider.dart';
import 'package:chat_app/src/services/database.dart';
import 'package:chat_app/src/shared/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Container(
        child: Stack(
          children: <Widget>[
            _MessageList(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _MessageField(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  final DataBaseMethods _db = DataBaseMethods();
  @override
  Widget build(BuildContext context) {
    final chatInfo = Provider.of<ChatInfoProvider>(context);
    Stream<QuerySnapshot> allMessages =
        _db.getConversationMessages(chatInfo.chatId);
    return allMessages == null
        ? CircularProgressIndicator()
        : StreamBuilder(
            stream: allMessages,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(

                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _MessageTile(
                      message: snapshot.data.documents[index].data['message'],
                      sentby: snapshot.data.documents[index].data['sendBy'],
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          );
  }
}

class _MessageTile extends StatelessWidget {
  final String message;
  final String sentby;
  const _MessageTile({@required this.message, @required this.sentby});
  @override
  Widget build(BuildContext context) {
    bool isItMe = false;
    final PreferenciasUsuario prefs = PreferenciasUsuario();
    if (prefs.userName == sentby) {
      isItMe = true;
    } else {
      isItMe = false;
    }
    return Row(
      mainAxisAlignment: isItMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: isItMe ? Alignment.centerRight: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isItMe ? Colors.blue[400] : Colors.grey[300],
            borderRadius: isItMe ? BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ): BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ) 
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 18.0
            ),
            //textAlign: isItMe ? TextAlign.right : TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class _MessageField extends StatelessWidget {
  final DataBaseMethods db = DataBaseMethods();
  sendMessage(String chatRoomId, String message, String sendby) {
    Map<String, dynamic> messageMap = {
      "message": message,
      "sendBy": sendby,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
    db.addConversationMessages(chatRoomId, messageMap);
  }

  @override
  Widget build(BuildContext context) {
    final chatInfo = Provider.of<ChatInfoProvider>(context);
    final PreferenciasUsuario _prefs = PreferenciasUsuario();
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 3.0),
      child: Row(
        children: <Widget>[
          Expanded(child: _TextMessageField()),
          SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              sendMessage(chatInfo.chatId, chatInfo.message, _prefs.userName);
              chatInfo.isSent = true;
            },
            icon: Icon(Icons.send, color: Colors.lightBlue, size: 30.0),
          ),
        ],
      ),
    );
  }
}

class _TextMessageField extends StatefulWidget {
  @override
  __TextMessageFieldState createState() => __TextMessageFieldState();
}

class __TextMessageFieldState extends State<_TextMessageField> {
  TextEditingController controller = TextEditingController();
  String text;
  @override
  Widget build(BuildContext context) {
    final chatInfo = Provider.of<ChatInfoProvider>(context);
    if (chatInfo.isSent) {
      setState(() {
        text = "";
        controller.text = text;
      });
    }
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type message',
        hintStyle: TextStyle(
          color: Colors.black45,
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
        color: Colors.black,
        fontSize: 20.0,
      ),
      onChanged: (message) {
        chatInfo.isSent = false;
        chatInfo.message = message;
      },
    );
  }
}
