import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../custom_divider.dart';
import 'bottom_modal_default.dart';

class BottomModalWithAlert extends StatelessWidget {
  final String funcName;
  final String title;
  final String body;
  final Function func;

  BottomModalWithAlert({this.funcName, this.title, this.body, this.func});

  @override
  Widget build(BuildContext context) {
    return BottomModalDefault(
      text: funcName,
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
                      title,
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
                    body,
                    style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: func,
                    child: Text(
                      funcName,
                      style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
