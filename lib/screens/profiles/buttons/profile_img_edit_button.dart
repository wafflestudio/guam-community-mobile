import 'package:flutter/material.dart';
import '../../../commons/buttons/common_text_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:io' show Platform;
import '../edit/profile_edit_img_modal.dart';

class ProfileImgEditButton extends StatelessWidget {
  final Function setImageFile;
  final Function resetImageFile;

  ProfileImgEditButton(this.setImageFile, this.resetImageFile);

  @override
  Widget build(BuildContext context) {
    return CommonTextButton(
      text: '프로필 사진 변경',
      fontSize: 12,
      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
      textColor: GuamColorFamily.purpleCore,
      onPressed: () {
        if (Platform.isAndroid) {
          showMaterialModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
              )
            ),
            context: context,
            useRootNavigator: true,
            builder: (_) => ProfileEditImgModal(setImageFile, resetImageFile)
          );
        } else {
        showCupertinoModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (_) => ProfileEditImgModal(setImageFile, resetImageFile)
          );
        }
      },
    );
  }
}
