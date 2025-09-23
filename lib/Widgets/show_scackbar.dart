import 'package:e_commerce/Widgets/show_scackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
