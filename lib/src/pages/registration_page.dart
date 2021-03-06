import 'package:chat_app/src/widgets/already_account_line.dart';
import 'package:chat_app/src/widgets/forgot_password_button.dart';
import 'package:chat_app/src/widgets/form_fields.dart';
import 'package:chat_app/src/widgets/google_button.dart';
import 'package:chat_app/src/widgets/loading_widget.dart';
import 'package:chat_app/src/widgets/log_button.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  static final String routeName = 'registration';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0061ff),
              Color(0xFF60efff),
            ],
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.2),
                    LoadingWidget(),
                    _Title(
                      title: 'Nearby',
                    ),
                    SizedBox(height: 20.0),
                    UserInfoField(formkey: formkey),
                    SizedBox(height: 20.0),
                    ForgotPasswordButton(),
                    SizedBox(height: 30.0),
                    LogButton(text: 'Sign Up', formKey: formkey),
                    SizedBox(height: 20.0),
                    GoogleButton(),
                    SizedBox(height: 20.0),
                    AlreadyAccount(
                      text1: 'Already have an account?',
                      text2: 'Sign in',
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _Title extends StatelessWidget {
  final String title;
  const _Title({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 50.0,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
