import 'package:chat_app/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future signInEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fireBaseUser = result.user;
      return _userFromFirebaseUser(fireBaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fireBaseUser = result.user;
      return _userFromFirebaseUser(fireBaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}
