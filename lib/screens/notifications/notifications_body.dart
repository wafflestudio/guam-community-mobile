import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/providers/notifications/notifications.dart';
import 'package:guam_community_client/screens/notifications/notifications_preview.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';

class NotificationsBody extends StatefulWidget {
  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  List _notifications = [];
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  ScrollController _scrollController = ScrollController();

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      await context.read<Notifications>().fetchNotifications();
      _notifications = context.read<Notifications>().notifications;
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() => _isLoadMoreRunning = true);
      try {
        _currentPage ++;
        final fetchedNotifications = await context.read<Notifications>().addNotifications(
          page: _currentPage,
        );
        if (fetchedNotifications != null && fetchedNotifications.length > 0) {
          setState(() => _notifications.addAll(fetchedNotifications));
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() => _hasNextPage = false);
        }
      } catch (err) {
        print('알 수 없는 오류가 발생했습니다.');
      }
      setState(() => _isLoadMoreRunning = false);
    }
  }

  @override
  void initState() {
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstLoadRunning
    ? Center(child: guamProgressIndicator())
    : Container(
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(top: 18),
        child: RefreshIndicator(
          color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
          onRefresh: () => context.read<Notifications>().fetchNotifications(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(children: [
                if (_notifications.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
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
                if (_notifications.isNotEmpty)
                  ..._notifications.map((noti) => NotificationsPreview(noti, onRefresh: _firstLoad)),
                if (_isLoadMoreRunning == true)
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: guamProgressIndicator(size: 40),
                  ),
                if (_hasNextPage == false && _currentPage > 2)
                  Container(
                    color: GuamColorFamily.purpleLight2,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(child: Text(
                      '모든 알림을 불러왔습니다!',
                      style: TextStyle(
                        fontSize: 13,
                        color: GuamColorFamily.grayscaleGray2,
                        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                      ),
                    )),
                  ),
              ]),
            ),
          ),
        ),
      );
  }
}
