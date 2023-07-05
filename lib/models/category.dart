import 'package:flutter/material.dart';

class Category{

  final String? id;
  final String? title;
  final Color? color;

  // const here means objects values cant change after creating
  const Category({required this.id, required this.title, this.color = Colors.orange});

}