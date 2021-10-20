import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final dynamic leading;
  final dynamic trailing;
  final Color backgroundColor;

  CustomAppBar({this.title, this.leading, this.trailing, this.backgroundColor});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.black;
    var iconColor = Colors.black;

    if (Platform.isAndroid) {
      return AppBar(
        title: Text(
          title ?? "",
          style: TextStyle(color: textColor),
        ),
        leading: Material(
          color: Colors.transparent,
          child: leading,
        ),
        actions: trailing == null
            ? []
            : [Material(color: Colors.transparent, child: trailing)],
        backgroundColor: backgroundColor ?? Colors.white,
        iconTheme: IconThemeData(
          color: iconColor,
        ),
      );
    } else {
      return CupertinoNavigationBar(
        middle: Text(
          title ?? "",
          style: TextStyle(
            color: textColor,
          ),
        ),
        leading: Material(
          color: Colors.transparent,
          child: leading,
        ),
        trailing: Material(
          color: Colors.transparent,
          child: trailing,
        ),
        backgroundColor: backgroundColor ?? Colors.transparent,
      );
    }
  }
}
