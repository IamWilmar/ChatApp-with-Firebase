import 'package:chat_app/src/models/user.dart';
import 'package:chat_app/src/pages/contacts_page.dart';
import 'package:chat_app/src/pages/registration_page.dart';
import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:chat_app/src/providers/page_provider.dart';
import 'package:chat_app/src/providers/right_info_provider.dart';
import 'package:chat_app/src/providers/user_data.dart';
import 'package:chat_app/src/services/auth.dart';
import 'package:chat_app/src/services/database.dart';
import 'package:chat_app/src/shared/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LogButton extends StatelessWidget {
  final String text;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldkey;
  LogButton({this.text, this.formKey, this.scaffoldkey});
  final AuthMethods authMethods = AuthMethods();
  final DataBaseMethods db = DataBaseMethods();
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    final userData = Provider.of<UserLogInfo>(context);
    final loadingChecker = Provider.of<LoadingProvider>(context);
    final infoCheck = Provider.of<RightLogProvider>(context);
    final PreferenciasUsuario preferenciasUsuario = PreferenciasUsuario();

    return GestureDetector(
      onTap: () {
        SystemChannels.textInput
            .invokeMethod('TextInput.hide'); //To hide the keyboard
        if (formKey.currentState.validate()) {
          loadingChecker.isLoading = true;
          if (pageProvider.actualRoute == RegisterPage.routeName) {
            authMethods
                .signUpEmailAndPassword(userData.email, userData.password)
                .then((User val) {
              if (val != null) {
                print('Well done ${val.userId}');
                Map<String, String> userInfoMap = {
                  'name': userData.username,
                  'email': userData.email,
                };
                preferenciasUsuario.isUserLogged = true;
                preferenciasUsuario.userName = userData.username;
                preferenciasUsuario.userEmail = userData.email;
                preferenciasUsuario.userPassword = userData.password;
                db.uploadUserInfo(userInfoMap);
                loadingChecker.isLoading = false;
                Navigator.pushReplacementNamed(context, ContactsPage.routeName);
              } else {
                loadingChecker.isLoading = false;
              }
            });
          } else {
            authMethods
                .signInEmailAndPassword(userData.email, userData.password)
                .then((User val) async {
              if (val != null) {
                await db.getUsernamebyId(userData.email).then((val) {
                  print(val.documents[0].data['name'].toString());
                  preferenciasUsuario.userName = val.documents[0].data['name'];
                  print(
                      'HELLLO PAY ATTENTION TO THIS: ${preferenciasUsuario.userName}');
                });
                preferenciasUsuario.userEmail = userData.email;
                preferenciasUsuario.userPassword = userData.password;
                preferenciasUsuario.isUserLogged = true;
                infoCheck.isRight = true;
                loadingChecker.isLoading = false;
                Navigator.pushReplacementNamed(context, ContactsPage.routeName);
              } else {
                infoCheck.isRight = false;
                loadingChecker.isLoading = false;
                _mostrarSnackBar(context, 'Email or Password Incorrect');
                infoCheck.isRight = true;
              }
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

  void _mostrarSnackBar(BuildContext context, String wordEs) {
    final snackbar = SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.grey,
      content: Text(
        wordEs,
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 1000),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
