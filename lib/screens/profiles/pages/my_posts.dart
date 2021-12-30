import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:provider/provider.dart';
import '../../../models/boards/post.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';
import '../../../models/profiles/profile.dart';

class MyPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '내가 쓴 글',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: []
            ),
          ),
        )
    );
  }
}
