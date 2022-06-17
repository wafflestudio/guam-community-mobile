import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:guam_community_client/commons/common_text_button.dart';

import '../../../helpers/pick_image.dart';

class ProfileEditImgModal extends StatelessWidget {
  final Function setImageFile;
  final Function resetImageFile;

  const ProfileEditImgModal(this.setImageFile, this.resetImageFile);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextButton(
                text: '사진 가져오기',
                fontSize: 16,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                textColor: GuamColorFamily.grayscaleGray1,
                onPressed: () => pickImage(type: 'gallery').then((img) {
                  setImageFile(img);
                }),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              CommonTextButton(
                text: '기본 사진으로 설정',
                fontSize: 16,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                textColor: GuamColorFamily.grayscaleGray1,
                onPressed: () => resetImageFile(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
