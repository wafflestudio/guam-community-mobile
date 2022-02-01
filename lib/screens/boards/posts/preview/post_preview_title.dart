import 'package:flutter/material.dart';

class PostPreviewTitle extends StatelessWidget {
  final String title;

  PostPreviewTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 14),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
