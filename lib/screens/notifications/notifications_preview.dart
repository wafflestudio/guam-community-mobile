import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/notification.dart' as Notification;
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class NotificationsPreview extends StatelessWidget {
  final Notification.Notification notification;

  NotificationsPreview(this.notification);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Container(
            padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
            child: InkWell(
              onTap: () {
                // Navigator.of(context).push(
                  // MaterialPageRoute(builder: (_) => NotificationsBody(
                    // messages,
                    // messageBox.otherProfile.nickname,
                  // ))
                // );
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
                              image: notification.otherProfile.profileImg != null
                                  ? NetworkImage(notification.otherProfile.profileImg.urlPath)
                                  : SvgProvider('assets/icons/profile_image.svg')
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Positioned(
                          top: 0,
                          child: CircleAvatar(
                            backgroundColor: GuamColorFamily.fuchsiaCore,
                            radius: 6,
                          )
                        ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.79,
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.otherProfile.nickname
                            + _typeDescription(notification.type),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                            color: notification.isRead
                                ? GuamColorFamily.grayscaleGray3
                                : GuamColorFamily.grayscaleGray1,
                          ),
                        ),
                        if (notification.comment != null)
                          Text(
                            notification.comment,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.6,
                              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                              color: notification.isRead
                                  ? GuamColorFamily.grayscaleGray4
                                  : GuamColorFamily.grayscaleGray3,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            (DateTime.now().minute - notification.createdAt.minute).toString() + "분 전",
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

  _typeDescription(String type) {
    String description;
    switch (type) {
      case 'commented': description = ' 님이 댓글을 남겼습니다.'; break;
      case 'scrapped': description = ' 님이 나의 게시글을 저장했습니다.'; break;
      case 'post_liked': description = ' 님이 나의 게시글을 좋아합니다.'; break;
      case 'comment_liked': description = ' 님이 나의 댓글을 좋아합니다.'; break;
      default: break;
    }
    return description;
  }

}
