import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/styles/colors.dart';

class MessageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '쪽지함',
        leading: Back(),
        trailing: Padding(
            padding: EdgeInsets.only(right: 11),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size(30, 26),
                alignment: Alignment.center,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: SvgPicture.asset('assets/icons/delete_outlined.svg'),
                onPressed: () {},
              ),
            )
        ),
      ),
      body: Container(
        color: GuamColorFamily.grayscaleWhite,
      ),
    );
  }
}
