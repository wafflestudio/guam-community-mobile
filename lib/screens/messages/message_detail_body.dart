import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_divider.dart';
import '../../commons/image/image_carousel.dart';
import '../../models/profiles/profile.dart';
import '../../providers/user_auth/authenticate.dart';

class MessageDetailBody extends StatelessWidget {
  final Message message;
  final Profile otherProfile;

  MessageDetailBody(this.message, this.otherProfile);

  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();
    bool isMe = message.sentBy == authProvider.me.id;
    Profile sentBy = isMe ? authProvider.me : otherProfile;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: sentBy.profileImg != null
                        ? NetworkImage(HttpRequest().s3BaseAuthority + sentBy.profileImg)
                        : SvgProvider('assets/icons/profile_image.svg')
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  isMe ? sentBy.nickname + ' (나)': sentBy.nickname,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    color: isMe
                        ? GuamColorFamily.purpleCore
                        : GuamColorFamily.grayscaleGray2,
                  ),
                ),
              ),
              Spacer(),
              Text(
                Jiffy(message.createdAt).fromNow() == "몇 초 후"
                    ? "몇 초 전"
                    : Jiffy(message.createdAt).fromNow(),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray4,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 8, bottom: 10),
            child: Text(
              message.text,
              style: TextStyle(
                height: 1.6,
                fontSize: 13,
                color: GuamColorFamily.grayscaleGray2,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              ),
            ),
          ),
          if (message.imagePath != null)
            InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(HttpRequest().s3BaseAuthority + message.imagePath),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => ImageCarousel(
                      pictures: [message.imagePath],
                      initialPage: 0,
                      showImageCount: false,
                      showImageActions: true,
                    ),
                  ),
                );
              },
            ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
          ),
        ],
      ),
    );
  }
}
