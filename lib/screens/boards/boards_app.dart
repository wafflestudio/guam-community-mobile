import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/posts/post_button.dart';
import 'package:guam_community_client/screens/messages/message.dart';
import 'package:provider/provider.dart';
import '../../commons/custom_app_bar.dart';
import 'boards_body.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Posts(authToken: context.read<Authenticate>().authToken)),
      ],
      child: BoardsAppScaffold(),
    );
  }
}

class BoardsAppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '홈',
        trailing: Message()
      ),
      body: BoardsBody(),
      floatingActionButton: PostButton()
    );
  }
}
