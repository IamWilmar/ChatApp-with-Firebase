import 'package:chat_app/src/pages/contacts_page.dart';
import 'package:chat_app/src/pages/registration_page.dart';
import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:chat_app/src/providers/page_provider.dart';
import 'package:chat_app/src/providers/user_data.dart';
import 'package:chat_app/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LogButton extends StatelessWidget {
  final String text;
  final GlobalKey<FormState> formKey;
  LogButton({this.text, this.formKey});
  final AuthMethods authMethods = AuthMethods();
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    final userData = Provider.of<UserLogInfo>(context);
    final loadingChecker = Provider.of<LoadingProvider>(context);
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide'); //To hide the keyboard
        if (formKey.currentState.validate()) {
          loadingChecker.isLoading = true;
          if (pageProvider.actualRoute == RegisterPage.routeName) {
            authMethods.signUpEmailAndPassword(
                userData.email, userData.password).then((val){
                  //print('${val.id}');
                  loadingChecker.isLoading = false;
                  Navigator.pushReplacementNamed(context, ContactsPage.routeName);
                });
          } else {
            authMethods.signInEmailAndPassword(
                userData.email, userData.password).then((val){
                  //print('${val.id}');
                  loadingChecker.isLoading = false;
                  Navigator.pushReplacementNamed(context, ContactsPage.routeName);
                });
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          //color: Color(0xFF60efff),
          gradient: RadialGradient(
            radius: 7.0,
            colors: [
              Color(0xFF2566CD),
              Color(0xFF49A9D9),
            ],
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
