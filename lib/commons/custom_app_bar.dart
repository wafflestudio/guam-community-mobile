import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final dynamic leading;
  final dynamic trailing;
  final dynamic bottom;
  final Color? titleColor;
  final Color? backgroundColor;

  CustomAppBar({this.title, this.leading, this.trailing, this.bottom, this.titleColor, this.backgroundColor});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    var textColor = titleColor != null
        ? titleColor : GuamColorFamily.grayscaleGray1;
    var iconColor = GuamColorFamily.grayscaleGray1;
    return AppBar(
      centerTitle: true,
      elevation: 0.7,
      title: Text(
        title ?? "",
        style: TextStyle(color: textColor),
      ),
      leading: leading != null
          ? Material(color: Colors.transparent, child: leading)
          : null,
      automaticallyImplyLeading: false,
      bottom: bottom,
      actions: trailing == null
          ? []
          : [Material(color: Colors.transparent, child: trailing)],
      backgroundColor: backgroundColor ?? GuamColorFamily.grayscaleWhite,
      iconTheme: IconThemeData(
        color: iconColor,
      ),
    );
  }
}
