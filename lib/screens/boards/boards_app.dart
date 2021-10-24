import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/boards/posts/posts.dart';
import 'package:guam_community_client/screens/messages/message.dart';
import '../../commons/custom_app_bar.dart';
import 'boards_body.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '홈',
        trailing: Message()
      ),
      body: BoardsBody(),
      floatingActionButton: Posts()
    );
  }
}
