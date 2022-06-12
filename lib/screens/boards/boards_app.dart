import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/search/search.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/boards_type.dart';
import 'package:guam_community_client/screens/boards/posts/post_button.dart';
import 'package:guam_community_client/screens/messages/message_box.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../commons/custom_app_bar.dart';
import 'boards_feed.dart';
import 'boards_type.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Posts(authProvider)),
        ChangeNotifierProvider(create: (_) => Search(authProvider)),
        ChangeNotifierProvider(create: (_) => Messages(authProvider)),
      ],
      child: BoardsAppScaffold(),
    );
  }
}

class BoardsAppScaffold extends StatefulWidget {
  @override
  State<BoardsAppScaffold> createState() => _BoardsAppScaffoldState();
}

class _BoardsAppScaffoldState extends State<BoardsAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: GuamColorFamily.purpleLight3,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(
            title: '홈',
            trailing: MessageBox(),
            bottom: TabBar(
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              labelColor: GuamColorFamily.grayscaleGray1,
              unselectedLabelColor: GuamColorFamily.grayscaleGray4,
              indicatorColor: GuamColorFamily.grayscaleGray1,
              indicatorWeight: 2,
              tabs: [
                ...boardsList.map((board) => Tab(
                    child: Text(boardsType[board['name']])
                ))
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            ...boardsList.map((board) => BoardsFeed(boardId: board['id']))
          ],
        ),
        floatingActionButton: PostButton()
      )
    );
  }
}
