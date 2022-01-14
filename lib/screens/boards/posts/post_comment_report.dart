import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_default.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
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
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '사용자 신고하기',
                          style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                        ),
                        TextButton(
                          child: Text(
                            '취소',
                            style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(30, 26),
                            alignment: Alignment.centerRight,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    CustomDivider(color: GuamColorFamily.grayscaleGray7),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        '${widget.profile.nickname} 님을 신고하는 이유를 알려주세요',
                        style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular),
                      ),
                    ),
                    Column(
                      children: [
                        _choice(myState, '욕설/비방/음담패설'),
                        _choice(myState, '사행성 게시물'),
                        _choice(myState, '불법 복제/무단 도용'),
                        _choice(myState, '게시글/댓글 도배'),
                        _choice(myState, '기타'),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: GuamColorFamily.grayscaleGray6),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          '허위 신고자는 서비스 이용에 불이익을 받을 수 있으니 신중하게 신고해주세요. 자세한 사항은 개발자 문의를 이용해주세요.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: GuamColorFamily.grayscaleGray2,
                            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '신고하기',
                          style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
