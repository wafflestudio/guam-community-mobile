import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../commons/common_img_nickname.dart';
import '../../../providers/posts/posts.dart';
import '../../../providers/share/share.dart';

class PostInfo extends StatefulWidget {
  final int? index;
  final Post? post;
  final Function? refreshPost;
  final double iconSize;
  final bool showProfile;
  final bool profileClickable;
  final HexColor? iconColor;

  PostInfo({
    this.index,
    this.post,
    this.refreshPost,
    this.iconSize = 20,
    this.showProfile = true,
    this.profileClickable = true,
    this.iconColor,
  });

  @override
  State<PostInfo> createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  bool? isLiked;
  bool? isScrapped;
  int? likeCount;
  int? scrapCount;

  @override
  void initState() {
    isLiked = widget.post!.isLiked;
    isScrapped = widget.post!.isScrapped;
    likeCount = widget.post!.likeCount;
    scrapCount = widget.post!.scrapCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = context.watch<Posts>();
    final share = Share(context: context);

    Future likeOrUnlikePost() async {
      try {
        if (!isLiked!) {
          return await postsProvider.likePost(
            postId: widget.post!.id,
          ).then((successful) async {
            if (successful) {
              Post? _temp = await (postsProvider.getPost(widget.post!.id));
              isLiked = _temp?.isLiked;
              likeCount = _temp?.likeCount;
              widget.refreshPost!(widget.index, _temp);
            } else {
              return postsProvider.fetchPosts(postsProvider.boardId);
            }
          });
        } else {
          return await postsProvider.unlikePost(
            postId: widget.post!.id,
          ).then((successful) async {
            if (successful) {
              Post? _temp = await (postsProvider.getPost(widget.post!.id));
              isLiked = _temp?.isLiked;
              likeCount = _temp?.likeCount;
              widget.refreshPost!(widget.index, _temp);
            } else {
              return postsProvider.fetchPosts(postsProvider.boardId);
            }
          });
        }
      } catch (e) {
        print(e);
      }
    }

    Future scrapOrUnscrapPost() async {
      try {
        if (!isScrapped!) {
          return await postsProvider.scrapPost(
            postId: widget.post!.id,
          ).then((successful) {
            if (successful) {
              setState(() {
                isScrapped = true;
                scrapCount = scrapCount! + 1;
              });
            } else {
              return postsProvider.fetchPosts(postsProvider.boardId);
            }
          });
        } else {
          return await postsProvider.unscrapPost(
            postId: widget.post!.id,
          ).then((successful) {
            if (successful) {
              setState(() {
                isScrapped = !isScrapped!;
                scrapCount = scrapCount! - 1;
              });
            } else {
              return postsProvider.fetchPosts(postsProvider.boardId);
            }
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        children: [
          if (widget.showProfile)
            CommonImgNickname(
              imgUrl: widget.post!.profile!.profileImg,
              nickname: widget.post!.profile!.nickname,
              profileClickable: widget.profileClickable,
              nicknameColor: GuamColorFamily.grayscaleGray2,
            ),
          if (widget.showProfile) Spacer(),
          Row(
            children: [
              IconText(
                iconSize: widget.iconSize,
                text: likeCount.toString(),
                iconPath: isLiked!
                    ? 'assets/icons/like_filled.svg'
                    : 'assets/icons/like_outlined.svg',
                onPressed: likeOrUnlikePost,
                iconColor: isLiked!
                    ? GuamColorFamily.redCore
                    : widget.iconColor,
                textColor: widget.iconColor,
              ),
              IconText(
                iconSize: widget.iconSize,
                text: widget.post!.commentCount.toString(),
                iconPath: 'assets/icons/comment.svg',
                iconColor: widget.iconColor,
                textColor: widget.iconColor,
              ),
              IconText(
                iconSize: widget.iconSize,
                text: scrapCount.toString(),
                iconPath: isScrapped!
                    ? 'assets/icons/scrap_filled.svg'
                    : 'assets/icons/scrap_outlined.svg',
                onPressed: scrapOrUnscrapPost,
                iconColor: isScrapped!
                    ? GuamColorFamily.purpleCore
                    : widget.iconColor,
                textColor: widget.iconColor,
              ),
            ],
          ),
          if(!widget.showProfile)Spacer(),
          if(!widget.showProfile)IconButton(
            icon: SvgPicture.asset(
              'assets/icons/share_outlined.svg',
              color: widget.iconColor,
            ),
            onPressed: () => share.share(widget.post!.id, widget.post!.title),
          ),
        ],
      ),
    );
  }
}
