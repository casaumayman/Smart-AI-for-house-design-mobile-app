import 'dart:io';
import 'package:flutter/material.dart';

class ImageScaffold extends StatelessWidget {
  const ImageScaffold({super.key, required this.path, this.testing = false});
  final String path;
  final bool testing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: testing
          ? Image.network(path, fit: BoxFit.contain)
          : Image.file(File(path), fit: BoxFit.contain),
    );
  }
}
