import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(  
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 20.0),
          Icon(Icons.bubble_chart),
          SizedBox(width: 35.0),
          Text('Sign in with Google',
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}