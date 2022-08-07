import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/notification.dart' as Notification;
import 'package:guam_community_client/providers/notifications/notifications.dart';
import 'package:guam_community_client/screens/notifications/notifications_type.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../models/boards/post.dart';
import '../../providers/posts/posts.dart';
import '../../providers/user_auth/authenticate.dart';
import '../boards/posts/detail/post_detail.dart';

class NotificationsPreview extends StatefulWidget{
  final Notification.Notification notification;
  final Function onRefresh;

  NotificationsPreview(this.notification, {this.onRefresh});

  @override
  State<NotificationsPreview> createState() => _NotificationsPreviewState();
}

class _NotificationsPreviewState extends State<NotificationsPreview> with Toast {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    Posts postProvider = context.read<Posts>();
    Authenticate authProvider = context.read<Authenticate>();
    Notifications notiProvider = context.read<Notifications>();

    Future<Post> _getPost() {
      return Future.delayed(Duration(seconds: 0), () async {
        Post _post = await postProvider.getPost(int.parse(widget.notification.linkUrl.split('/')[4]));
        setState(() => isLoading = false);

        /// read notification API
        await notiProvider.readNotifications(
          userId: authProvider.me.id,
          pushEventIds: [widget.notification.id.toString()],
        );
        widget.onRefresh();
        return _post;
      });
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Container(
            padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_) => Posts(authProvider)),
                      ],
                      child: FutureBuilder(
                        /// todo: linkUrl 을 '/'로 split 하여 postId 추출 => postId 값만 보내주기
                        future: _getPost(),
                        builder: (_, AsyncSnapshot<Post> snapshot) {
                          if (snapshot.hasData) {
                            return PostDetail(post: snapshot.data);
                          } else if (snapshot.hasError || !isLoading) {
                            Navigator.pop(context);
                            return Container();
                          } else {
                            return Center(child: guamProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: widget.notification.writer.profileImg != null && widget.notification.writer.profileImg.isNotEmpty
                                  ? NetworkImage(HttpRequest().s3BaseAuthority +  widget.notification.writer.profileImg)
                                  : SvgProvider('assets/icons/profile_image.svg')
                          ),
                        ),
                      ),
                      if (!widget.notification.isRead)
                        Positioned(
                            top: -2,
                            left: -2,
                            child: CircleAvatar(
                              backgroundColor: GuamColorFamily.grayscaleWhite,
                              radius: 8,
                              child: CircleAvatar(
                                backgroundColor: GuamColorFamily.fuchsiaCore,
                                radius: 6,
                              ),
                            )
                        ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.notification.writer.nickname,
                              style: TextStyle(
                                fontSize: 13,
                                color: widget.notification.isRead
                                    ? GuamColorFamily.grayscaleGray3
                                    : GuamColorFamily.grayscaleGray1,
                              ),
                            ),
                            Text(
                              notificationsType(widget.notification.kind),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                                color: widget.notification.isRead
                                    ? GuamColorFamily.grayscaleGray3
                                    : GuamColorFamily.grayscaleGray1,
                              ),
                            ),
                          ],
                        ),
                        if (widget.notification.body != null)
                          Text(
                            widget.notification.body,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.6,
                              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                              color: widget.notification.isRead
                                  ? GuamColorFamily.grayscaleGray4
                                  : GuamColorFamily.grayscaleGray3,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            Jiffy(widget.notification.createdAt).fromNow(),
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.6,
                              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                              color: GuamColorFamily.grayscaleGray4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
        )
      ],
    );
  }
}
