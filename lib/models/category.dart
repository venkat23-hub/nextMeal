import 'package:flutter/material.dart';
class Category extends StatelessWidget {
  const Category({
    required this.id,
    required this.title,
     required this.image,
  });
  final String id;
  final String title;
  final Image image;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
