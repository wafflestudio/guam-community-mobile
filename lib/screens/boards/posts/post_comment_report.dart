import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_default.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_with_choice.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostCommentReport extends StatefulWidget {
  final Profile profile;

  PostCommentReport(this.profile);

  @override
  _PostCommentReportState createState() => _PostCommentReportState();
}

class _PostCommentReportState extends State<PostCommentReport> {
  String reportReason = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomModalDefault(
      text: '신고하기',
      onPressed: () => showMaterialModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: GuamColorFamily.grayscaleWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
            return BottomModalWithChoice(
              title: '사용자 신고하기',
              back: '취소',
              body: '${widget.profile.nickname} 님을 신고하는 이유를 알려주세요',
              alert: '허위 신고자는 서비스 이용에 불이익을 받을 수 있으니 신중하게 신고해주세요. 자세한 사항은 개발자 문의를 이용해주세요.',
              confirm: '신고하기',
              children: [
                _choice(myState, '욕설/비방/음담패설'),
                _choice(myState, '사행성 게시물'),
                _choice(myState, '불법 복제/무단 도용'),
                _choice(myState, '게시글/댓글 도배'),
                _choice(myState, '기타'),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _choice(StateSetter myState, String choice) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => myState(() => reportReason = choice),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 24,
                child: Text(
                  choice,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    color: choice == reportReason
                        ? GuamColorFamily.purpleCore
                        : GuamColorFamily.grayscaleGray3,
                  ),
                ),
              ),
              if (choice == reportReason)
                IconButton(
                  padding: EdgeInsets.only(right: 8),
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/check.svg'),
                  onPressed: null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
