import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_default.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommentBanner extends StatelessWidget {
  final Comment comment;

  CommentBanner(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: comment.profile.profileImg != null
                    ? NetworkImage(comment.profile.profileImg.urlPath)
                    : SvgProvider('assets/icons/profile_image.svg'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              comment.profile.nickname,
              style: TextStyle(
                fontSize: 12,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray3,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              'assets/icons/more.svg',
              color: GuamColorFamily.grayscaleGray5,
            ),
            onPressed: () => showMaterialModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: GuamColorFamily.grayscaleWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 24, top: 24, bottom: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!comment.isAuthor)
                        BottomModalDefault(
                          text: '쪽지보내기',
                          onPressed: (){},
                        ),
                      BottomModalDefault(
                        text: comment.isAuthor ? '수정하기' : '신고하기',
                        onPressed: (){},
                      ),
                      BottomModalDefault(
                        text: comment.isAuthor ? '삭제하기' : '차단하기',
                        onPressed: (){},
                      ),
                    ],
                  ),
                ),
              )
            )
          ),
        ],
      ),
    );
  }
}
