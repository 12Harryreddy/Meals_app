

import 'package:flutter/material.dart';

class Category {
  const Category({this.color = Colors.orange, required this.title, required this.id});
  final String id;
  final String title;
  final Color color;
}