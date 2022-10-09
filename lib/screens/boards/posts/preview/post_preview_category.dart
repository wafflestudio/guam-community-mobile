import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/color_of_category.dart';
import 'package:guam_community_client/models/boards/post.dart';

class PostPreviewCategory extends StatelessWidget {
  final Post post;

  PostPreviewCategory(this.post);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 17,
      child: TextButton(
        onPressed: null,
        child: Text(
          "#" + post.category!.title!,
          style: TextStyle(
            fontSize: 12,
            color: colorOfCategory(post.category!.title),
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
