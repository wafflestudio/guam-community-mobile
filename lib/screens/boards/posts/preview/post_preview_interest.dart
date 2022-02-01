import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/color_of_interest.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostPreviewInterest extends StatelessWidget {
  final Post post;

  PostPreviewInterest(this.post);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 17,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "#" + post.interest,
          style: TextStyle(
            fontSize: 12,
            color: colorOfInterest(post.interest),
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
