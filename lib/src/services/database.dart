import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{
  getUsernameSearch(String username) async {
    return await Firestore.instance.collection('Users').where('name', isEqualTo: username).getDocuments();
  }

  getUsernamebyId(String email) async {
    return await Firestore.instance.collection('Users').where('email', isEqualTo: email).getDocuments();
  }

  uploadUserInfo(userMap){
    try{
      Firestore.instance.collection('Users').add(userMap);
    }catch(e){
      print(e.toString());
    }
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    try{
      Firestore.instance.collection('ChatRoom').document(chatRoomId).setData(chatRoomMap);
    }catch(e){
      print(e.toString());
    }
  }


}