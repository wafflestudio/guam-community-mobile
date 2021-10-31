import 'package:flutter/material.dart';

class SubHeadings extends StatelessWidget {
  final String subheading;

  SubHeadings(this.subheading);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        subheading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
