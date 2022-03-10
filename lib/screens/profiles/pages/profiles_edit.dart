import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_img_edit_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_text_button.dart';
import '../../../commons/custom_divider.dart';
import '../profile/profile_img.dart';
import '../edit/profile_edit_nickname.dart';
import '../edit/profile_edit_intro.dart';
import '../edit/profile_edit_optional.dart';

class ProfilesEdit extends StatefulWidget {
  final Profile profile;

  ProfilesEdit(this.profile);

  @override
  State<ProfilesEdit> createState() => _ProfilesEditState();
}

class _ProfilesEditState extends State<ProfilesEdit> {
  Map<String, dynamic> input = {};

  @override
  void initState() {
    input['nickname'] = widget.profile.nickname;
    input['introduction'] = widget.profile.intro;
    input['githubId'] = widget.profile.githubId;
    input['blogUrl'] = widget.profile.blogUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg'),
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
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '프로필 수정을 취소하시겠어요?',
                          style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                        ),
                        TextButton(
                          child: Text(
                            '돌아가기',
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
                        '수정된 내용이 사라집니다.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: GuamColorFamily.grayscaleGray2,
                          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.maybePop(context);
                        },
                        child: Text(
                          '취소하기',
                          style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        title: '프로필 수정',
        trailing: Padding(
          padding: EdgeInsets.only(right: 8),
          child: CommonTextButton(
            text: '완료',
            fontSize: 16,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
            textColor: GuamColorFamily.purpleCore,
            onPressed: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileImg(profileImg: widget.profile.profileImg, height: 96, width: 96),
              ProfileImgEditButton(),
              ProfileEditNickname(input['nickname']),
              ProfileEditIntro(input['introduction']),
              ProfileEditOptional(input),
            ],
          ),
        ),
      ),
    );
  }
}
