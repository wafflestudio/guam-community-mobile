import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_img_nickname.dart';
import '../../../commons/guam_progress_indicator.dart';
import '../../../styles/fonts.dart';
import '../buttons/blacklist_remove_button.dart';

class BlackListEdit extends StatefulWidget {
  @override
  State<BlackListEdit> createState() => _BlackListEditState();
}

class _BlackListEditState extends State<BlackListEdit> {
  List<Profile> _blacklist = [];
  // int _currentPage = 1;
  // bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  // bool _isLoadMoreRunning = false;
  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      await context.read<Authenticate>().fetchBlockedUsers();
      _blacklist = context.read<Authenticate>().blockedUsers;
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  // void _loadMore() async {
  //   if (_hasNextPage == true &&
  //       _isFirstLoadRunning == false &&
  //       _isLoadMoreRunning == false &&
  //       _scrollController.position.extentAfter < 300) {
  //     setState(() => _isLoadMoreRunning = true);
  //     try {
  //       _currentPage ++;
  //       final fetchedBlacklist = await context.read<Authenticate>().addBlockedUsers(
  //         page: _currentPage,
  //       );
  //       if (fetchedBlacklist != null && fetchedBlacklist.length > 0) {
  //         setState(() => _notifications.addAll(fetchedBlacklist));
  //       } else {
  //         // This means there is no more data
  //         // and therefore, we will not send another GET request
  //         setState(() => _hasNextPage = false);
  //       }
  //     } catch (err) {
  //       print('알 수 없는 오류가 발생했습니다.');
  //     }
  //     setState(() => _isLoadMoreRunning = false);
  //   }
  // }

  void _scrollToTop() => _scrollController
      .animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);

  @override
  void initState() {
    _firstLoad();
    // _scrollController = ScrollController()..addListener(_loadMore)
    _scrollController = ScrollController()
      ..addListener(() => setState(() {
        if (_scrollController.offset >= 300) {
          _showBackToTopButton = true; // show the back-to-top button
        } else {
          _showBackToTopButton = false; // hide the back-to-top button
        }
      }));
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(leading: Back(), title: '차단 목록 관리'),
      body: _isFirstLoadRunning
          ? Center(child: guamProgressIndicator())
          : Stack(
              children: [
                Container(
                  color: GuamColorFamily.grayscaleWhite,
                  padding: EdgeInsets.only(top: 18),
                  child: RefreshIndicator(
                    color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
                    onRefresh: () => context.read<Authenticate>().fetchBlockedUsers(),
                    child: Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            if (_blacklist.isEmpty)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                                  child: Text(
                                    '새로운 알림이 없습니다.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: GuamColorFamily.grayscaleGray4,
                                      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                                    ),
                                  ),
                                ),
                              ),
                            if (_blacklist.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.all(24),
                                child: Wrap(
                                  runSpacing: 12,
                                  children: [..._blacklist.map((e) => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonImgNickname(
                                        userId: e.id,
                                        imgUrl: e.profileImg,
                                        nickname: e.nickname,
                                      ),
                                      BlackListRemoveButton(e.id, _firstLoad)
                                    ],
                                  ))],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (_showBackToTopButton)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: _scrollToTop,
                      backgroundColor: GuamColorFamily.purpleLight1,
                      child: Icon(Icons.arrow_upward, size: 20, color: GuamColorFamily.grayscaleWhite),
                    ),
                  ),
              ],
            ),
    );
  }
}
