import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/posts/post_button.dart';
import 'package:guam_community_client/screens/messages/message_box.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../commons/custom_app_bar.dart';
import 'boards_feed.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String authToken = context.read<Authenticate>().authToken;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProfile(authToken: authToken)),
        ChangeNotifierProvider(create: (_) => Posts(authToken: authToken)),
        ChangeNotifierProvider(create: (_) => Messages(authToken: authToken)),
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
                Tab(child: Text('피드')),
                Tab(child: Text('익명')),
                Tab(child: Text('자유')),
                Tab(child: Text('구인')),
                Tab(child: Text('정보공유')),
                Tab(child: Text('홍보')),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            BoardsFeed(),
            BoardsFeed(),
            BoardsFeed(),
            BoardsFeed(),
            BoardsFeed(),
            BoardsFeed(),
          ],
        ),
        floatingActionButton: PostButton()
      )
    );
  }
}
