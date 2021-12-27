import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/image/image_carousel.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/posts/post_image.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';

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
          child: Text(
            post.content,
            style: TextStyle(
              height: 1.6,
              color: GuamColorFamily.grayscaleGray2,
              fontSize: 14,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular
            ),
          )
        ),
        if (post.pictures.isNotEmpty)
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: min(post.pictures.length, maxRenderImgCnt),
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            shrinkWrap: true,
            itemCount: min(post.pictures.length, maxRenderImgCnt),
            itemBuilder: (_, idx) => InkWell(
              child: PostImage(
                picture: post.pictures[idx],
                blur: post.pictures.length > maxRenderImgCnt && idx == maxRenderImgCnt - 1,
                hiddenImgCnt: post.pictures.length - maxRenderImgCnt,
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: context.read<Posts>(), // necessary?
                      child: ImageCarousel(
                        pictures: [...this.post.pictures],
                        initialPage: idx,
                        showImageActions: true,
                        // showImageActions: creatorId != null && context.read<Posts>().isMe(creatorId),
                        // deleteFunc: threadId != null ? deleteThreadImage
                        //     : commentId != null ? deleteCommentImage
                        //     : null,
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
