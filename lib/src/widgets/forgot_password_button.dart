import 'package:flutter/material.dart';
class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:195.0),
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}