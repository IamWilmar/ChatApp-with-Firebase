import 'package:chat_app/src/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<LoadingProvider>(context);
    return Center(
      child: Container(
        child: isLoading.isLoading
            ? CircularProgressIndicator(backgroundColor: Colors.white70)
            : null,
      ),
    );
  }
}