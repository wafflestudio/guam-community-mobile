import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:guam_community_client/commons/image/image_carousel.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/posts/post_image.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailBody extends StatelessWidget {
  final int maxRenderImgCnt = 4;
  final Post post;

  PostDetailBody(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 64),
          child: Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },
            text: post.content,
            style: TextStyle(
              height: 1.6,
              fontSize: 14,
              color: GuamColorFamily.grayscaleGray2,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
            linkStyle: TextStyle(
              height: 1.6,
              fontSize: 14,
              color: GuamColorFamily.blueCore,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
          ),
        ),
        if (post.imagePaths.isNotEmpty)
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: min(post.imagePaths.length, maxRenderImgCnt),
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            shrinkWrap: true,
            itemCount: min(post.imagePaths.length, maxRenderImgCnt),
            itemBuilder: (_, idx) => InkWell(
              child: PostImage(
                picture: post.imagePaths[idx],
                blur: post.imagePaths.length > maxRenderImgCnt && idx == maxRenderImgCnt - 1,
                hiddenImgCnt: post.imagePaths.length - maxRenderImgCnt,
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: context.read<Posts>(), // necessary?
                      child: ImageCarousel(
                        pictures: [...this.post.imagePaths],
                        initialPage: idx,
                        showImageActions: true,
                      ),
                    )
                  )
                );
              },
            ),
          ),
      ],
    );
  }
}
