import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_banner.dart';
import 'package:guam_community_client/screens/boards/posts/post_info.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';

class PostPreview extends StatelessWidget {
  final Post post;

  PostPreview(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 12),
        decoration: BoxDecoration(
          color: GuamColorFamily.grayscaleWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              // Posts provideer만 받고 싶다면...
              // MaterialPageRoute(
              //   builder: (_) => ChangeNotifierProvider.value(
              //     value: context.read<Posts>(),
              //     child: PostDetail(post),
              //   )
              // )

              // Posts와 MyProfile provideer 모두 받고 싶다면...
              MaterialPageRoute(
                builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => MyProfile(authToken: context.read<Authenticate>().authToken)),
                    ChangeNotifierProvider(create: (_) => Posts(authToken: context.read<Authenticate>().authToken)),
                  ],
                  child: PostDetail(post),
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostPreviewBanner(post),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    if (post.pictures.length > 0)
                    IconButton(
                      padding: EdgeInsets.only(right: 4),
                      constraints: BoxConstraints(),
                      icon: SvgPicture.asset(
                        'assets/icons/picture.svg',
                        color: GuamColorFamily.grayscaleGray5,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      post.title,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                post.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.6,
                  fontSize: 13,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: PostInfo(
                  post: post,
                  profileClickable: false,
                  iconColor: GuamColorFamily.grayscaleGray4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
