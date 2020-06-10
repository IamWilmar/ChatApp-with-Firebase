import 'package:flutter/material.dart';


class LoadingPage extends StatelessWidget {
  static final String routeName = 'loading';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
     ),
   );
  }
}