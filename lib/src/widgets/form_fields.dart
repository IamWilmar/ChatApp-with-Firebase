import 'package:chat_app/src/pages/log_in_page.dart';
import 'package:chat_app/src/pages/registration_page.dart';
import 'package:chat_app/src/providers/page_provider.dart';
import 'package:chat_app/src/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoField extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  const UserInfoField({@required this.formkey});

  @override
  _UserInfoFieldState createState() => _UserInfoFieldState();
}

class _UserInfoFieldState extends State<UserInfoField> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageprovider = Provider.of<PageProvider>(context);
    return Column(
      children: <Widget>[
        Builder(
          builder: (BuildContext context) {
            if (pageprovider.actualRoute == RegisterPage.routeName) {
              return _Username(formkey: widget.formkey);
            } else if (pageprovider.actualRoute == LogInPage.routeName) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
        _EmailField(formkey: widget.formkey),
        SizedBox(height: 10.0),
        _PasswordField(formkey: widget.formkey),
      ],
    );
  }
}

class _EmailField extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  const _EmailField({@required this.formkey});

  @override
  __EmailFieldState createState() => __EmailFieldState();
}

class __EmailFieldState extends State<_EmailField> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserLogInfo>(context);
    return TextFormField(
      validator: (val) {
        return RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val)
            ? null
            : "Enter correct email";
      },
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Example@gmail.com',
        hintStyle: TextStyle(color: Colors.white54),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
      ),
      onChanged: (email) {
        userInfo.email = email;
        setState(() {
          widget.formkey.currentState.validate();
        });
      },
    );
  }
}

class _PasswordField extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  const _PasswordField({@required this.formkey});

  @override
  __PasswordFieldState createState() => __PasswordFieldState();
}

class __PasswordFieldState extends State<_PasswordField> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserLogInfo>(context);
    return TextFormField(
      validator: (val) {
        if (val.length < 4) {
          return "4 or More characters";
        } else {
          return null;
        }
      },
      obscureText: true,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'at least 5 characters',
        hintStyle: TextStyle(color: Colors.white54),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
      ),
      onChanged: (pass) {
        userInfo.password = pass;
        setState(() {
          widget.formkey.currentState.validate();
        });
      },
    );
  }
}

class _Username extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  const _Username({@required this.formkey});

  @override
  __UsernameState createState() => __UsernameState();
}

class __UsernameState extends State<_Username> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserLogInfo>(context);
    return TextFormField(
      validator: (val) {
        if (val.length < 4) {
          return "4 or More characters";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white54),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
      ),
      onChanged: (username) {
        userInfo.username = username;
        setState(() {
          widget.formkey.currentState.validate();
        });
      },
    );
  }
}
