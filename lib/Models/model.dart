import 'package:flutter/material.dart';

class AppModel{
  final String name,image,description,category;
  final double rating;
  final int review, price;
  List<Color> fcolor;
  List<String> size;
  bool isCheck;

  AppModel(
      this.name,
      this.image,
      this.description,
      this.category,
      this.rating,
      this.review,
      this.price,
      this.fcolor,
      this.size,
      this.isCheck
      );


}