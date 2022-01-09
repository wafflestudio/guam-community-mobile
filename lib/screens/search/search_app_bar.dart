import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final dynamic trailing;
  final dynamic bottom;

  SearchAppBar({this.title, this.trailing, this.bottom});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    var textColor = GuamColorFamily.grayscaleGray1;
    var iconColor = GuamColorFamily.grayscaleGray1;

    return AppBar(
      elevation: 0.7,
      title: title,
      automaticallyImplyLeading: false,
      bottom: bottom,
      actions: trailing == null
          ? []
          : [Material(color: Colors.transparent, child: trailing)],
      backgroundColor: GuamColorFamily.grayscaleWhite,
      iconTheme: IconThemeData(
        color: iconColor,
      ),
    );
  }
}
