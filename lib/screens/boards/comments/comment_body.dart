import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../commons/image/image_container.dart';
import '../../../helpers/http_request.dart';
import '../../../providers/posts/posts.dart';

class CommentBody extends StatefulWidget {
  final Comment comment;

  CommentBody(this.comment);

  @override
  State<CommentBody> createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    isLiked = widget.comment.isLiked;
    likeCount = widget.comment.likeCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double maxImgSize = 96;
    final postsProvider = context.watch<Posts>();

    Future likeOrUnlikeComment() async {
      try {
        if (!isLiked) {
          return await postsProvider.likeComment(
            postId: widget.comment.postId,
            commentId: widget.comment.id,
          ).then((successful) {
            if (successful) {
              isLiked = true;
              likeCount ++;
            } else {
              return postsProvider.fetchPosts(postsProvider.boardId);
            }
          });
        } else {
          return await postsProvider.unlikeComment(
            postId: widget.comment.postId,
            commentId: widget.comment.id,
          ).then((successful) {
            if (successful) {
              setState(() {
                isLiked = false;
                likeCount --;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 32, right: 12),
          child: Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },
            text: widget.comment.content,
            style: TextStyle(
              height: 1.6,
              fontSize: 13,
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
        if (widget.comment.imagePaths.isNotEmpty)
          Container(
            padding: EdgeInsets.only(left: 23, top: 8, bottom: 8),
            constraints: BoxConstraints(maxHeight: maxImgSize + 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.comment.imagePaths.length,
              itemBuilder: (_, idx) => Container(
                padding: EdgeInsets.only(right: 10),
                child: ImageThumbnail(
                  width: maxImgSize,
                  height: maxImgSize,
                  image: Image(
                    image: NetworkImage(HttpRequest().s3BaseAuthority + widget.comment.imagePaths[idx]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(left: 32, top: 4, bottom: 8),
          child: Row(
            children: [
              IconText(
                iconSize: 18,
                fontSize: 10,
                text: likeCount.toString(),
                iconPath: isLiked
                    ? 'assets/icons/like_filled.svg'
                    : 'assets/icons/like_outlined.svg',
                onPressed: likeOrUnlikeComment,
                iconColor: isLiked
                    ? GuamColorFamily.redCore
                    : GuamColorFamily.grayscaleGray5,
                textColor: GuamColorFamily.grayscaleGray5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  Jiffy(widget.comment.createdAt).fromNow(),
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    color: GuamColorFamily.grayscaleGray4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
