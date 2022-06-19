import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_img_edit_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_text_button.dart';
import '../../../commons/custom_divider.dart';
import '../../../providers/user_auth/authenticate.dart';
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

class _ProfilesEditState extends State<ProfilesEdit> with Toast {
  bool sending = false;
  bool imgReset = true;
  Map<String, dynamic> input = {};
  List<dynamic> profileImage = [];
  String profileImg;

  @override
  void initState() {
    input['nickname'] = widget.profile.nickname;
    input['introduction'] = widget.profile.intro;
    input['githubId'] = widget.profile.githubId;
    input['blogUrl'] = widget.profile.blogUrl;
    profileImg = widget.profile.profileImg;
    super.initState();
  }

  void toggleSending() {
    setState(() => sending = !sending);
  }

  void setInput(String _key, String _value) {
    setState(() => input[_key] = _value);
  }

  Future<void> setImageFile(PickedFile val) async {
    setState(() {
      if (profileImage.isNotEmpty) profileImage.clear();
      if (val != null) profileImage.add(val);
    });
  }

  Future<void> resetImageFile() async {
    setState(() {
      imgReset = true;
      profileImg = null;
      if (profileImage.isNotEmpty) profileImage.clear();
    });
  }

  /// Deprecated: import the path of images from assets directory
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    var filePath = tempDir.path + '/tmp.png'; /// arbitrary name & extension
    return File(filePath).writeAsBytes(buffer.asUint8List(
      byteData.offsetInBytes, byteData.lengthInBytes,
    ));
  }

  Future setProfile() async {
    toggleSending();
    imgReset = profileImage.isEmpty && profileImg == null;
    try {
      if (input['nickname'] == null || input['nickname'] == '') {
        return showToast(success: false, msg: '닉네임을 설정해주세요.');
      }
      if (input['introduction'] == null) {
        return showToast(success: false, msg: '자기소개를 작성해주세요.');
      }
      await context.read<Authenticate>().setProfile(
        fields: input,
        files: profileImage.isNotEmpty
            ? [File(profileImage[0].path)] /// 프사 새롭게 추가
            : null,
        imgReset: imgReset,
      ).then((successful) {
        toggleSending();
        if (successful) {
          Navigator.maybePop(context);
        } else {
          print("Error!");
        }
      });
    } catch (e) {
      print(e);
    }
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
                          onPressed: () => Navigator.of(context).pop(),
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
            onPressed: () async => await setProfile(),
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
              ProfileImg(newImage: profileImage, profileImg: profileImg, height: 96, width: 96),
              ProfileImgEditButton(setImageFile, resetImageFile),
              ProfileEditNickname(input['nickname'], setInput),
              ProfileEditIntro(input['introduction'], setInput),
              ProfileEditOptional(input, setInput),
            ],
          ),
        ),
      ),
    );
  }
}
