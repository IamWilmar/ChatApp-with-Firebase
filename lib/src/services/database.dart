import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{
  getUsernameSearch(String username) async {
    return Firestore.instance.collection('Users').where('name', isEqualTo: username).getDocuments();
  }
  uploadUserInfo(userMap){
    try{
      Firestore.instance.collection('Users').add(userMap);
    }catch(e){
      print(e.toString());
    }
  }
}