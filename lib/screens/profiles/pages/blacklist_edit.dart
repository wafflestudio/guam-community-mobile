import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_img_nickname.dart';
import '../buttons/blacklist_remove_button.dart';

class BlackListEdit extends StatelessWidget {
  final List<Map> blacklist = [
    {
      'id': 4,
      'nickname': 'marcelko',
      'profileImageUrl': 'https://t1.daumcdn.net/cfile/tistory/99A97E4C5D25E9C226',
    },
    {
      'id': 5,
      'nickname': 'chadan1',
      'profileImageUrl': 'https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75',
    },
    {
      'id': 6,
      'nickname': 'marcelkor',
      'profileImageUrl': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '차단 목록 관리',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Wrap(
              runSpacing: 12,
              children: [...blacklist.map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonImgNickname(
                    imgUrl: e['profileImageUrl'],
                    nickname: e['nickname'],
                  ),
                  BlackListRemoveButton()
                ],
              ))],
            ),
          ),
        )
    );
  }
}
