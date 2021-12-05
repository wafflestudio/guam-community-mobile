import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_board.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_content.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_image.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_interest.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_title.dart';
import 'package:guam_community_client/styles/colors.dart';

class PostCreation extends StatefulWidget {
  @override
  State<PostCreation> createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  Map input = {
    'title': '',
    'content': '',
    'boardType': '',
    'interest': '',
    'images': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Back(),
        trailing: Padding(
          padding: EdgeInsets.only(right: 11),
          child: TextButton(
            onPressed: () {
              print(input);
            },
            style: TextButton.styleFrom(
              minimumSize: Size(30, 26),
              alignment: Alignment.center,
            ),
            child: Text(
              '등록',
              style: TextStyle(
                color: GuamColorFamily.purpleCore,
                fontSize: 16,
              ),
            ),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: GuamColorFamily.grayscaleWhite,
              padding: EdgeInsets.only(left: 24, top: 10, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostCreationBoard(input),
                  PostCreationTitle(input),
                  CustomDivider(color: GuamColorFamily.grayscaleGray7),
                  PostCreationContent(input),
                ],
              ),
            ),
            CustomDivider(
              height: 12,
              thickness: 12,
              color: GuamColorFamily.purpleLight3,
            ),
            Container(
              color: GuamColorFamily.grayscaleWhite,
              width: double.infinity,
              padding: EdgeInsets.only(left: 24, top: 16, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostCreationInterest(input),
                  PostCreationImage(input)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
