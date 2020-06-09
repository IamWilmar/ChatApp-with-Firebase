import 'package:chat_app/src/pages/loading_page.dart';
import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogButton extends StatelessWidget {
  final String text;
  final GlobalKey<FormState> formKey;
  const LogButton({this.text, this.formKey});
  Widget build(BuildContext context) {
    final loadingChecker = Provider.of<LoadingProvider>(context);
    return GestureDetector(
      onTap: (){
        if(formKey.currentState.validate()){
          loadingChecker.isLoading = true;
          if(loadingChecker.isLoading == true){
            Navigator.pushNamed(context, LoadingPage.routeName);
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
