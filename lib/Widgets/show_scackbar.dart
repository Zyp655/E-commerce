
import 'package:flutter/material.dart';
void showSnakeBar(BuildContext context , String message){
  ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      )
  );
}
