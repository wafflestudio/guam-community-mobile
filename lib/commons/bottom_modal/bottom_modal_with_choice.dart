import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../custom_divider.dart';

class BottomModalWithChoice extends StatelessWidget {
  final String title;
  final String back;
  final String body;
  final String alert;
  final String confirm;
  final List<Widget> children;

  BottomModalWithChoice({this.title, this.back, this.body, this.alert, this.confirm, this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 10),
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
                    back,
                    style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore),
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
            if (body != null)
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  body,
                  style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular),
                ),
              ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                children: children,
              ),
            ),
            if (alert != null)
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: GuamColorFamily.grayscaleGray6),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    alert,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: GuamColorFamily.grayscaleGray2,
                      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    ),
                  ),
                ),
              ),
            if (confirm != null)
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    confirm,
                    style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
