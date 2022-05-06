import 'package:flutter/material.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool turnPage = false;

  @override
  void initState() {
    context.read<Notifications>().fetchNotifications();

    _scrollController.addListener(() {
      turnPage = _scrollController.offset / _scrollController.position.maxScrollExtent >= 0.5;
      // if (turnPage && context.read<Notifications>().hasNext) addNotifications();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = context.read<Notifications>().notifications;

    return Container(
      color: GuamColorFamily.grayscaleWhite,
      padding: EdgeInsets.only(top: 18),
      child: RefreshIndicator(
        onRefresh: () => context.read<Notifications>().fetchNotifications(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: context.watch<Notifications>().loading
              ? Center(child: CircularProgressIndicator())
              : Column(children: [
                  if (notifications.isEmpty)
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
                  if (notifications.isNotEmpty)
                    ...notifications.map((noti) => NotificationsPreview(noti))
                ]),
        ),
      ),
    );
  }
}
