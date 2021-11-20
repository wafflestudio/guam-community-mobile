import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final dynamic leading;
  final dynamic trailing;
  final dynamic bottom;
  final Color backgroundColor;

  CustomAppBar({this.title, this.leading, this.trailing, this.bottom, this.backgroundColor});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.black;
    var iconColor = Colors.black;

    if (Platform.isAndroid) {
      return AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          title ?? "",
          style: TextStyle(color: textColor),
        ),
        leading: leading != null
            ? Material(color: Colors.transparent, child: leading)
            : null,
        bottom: bottom,
        actions: trailing == null
            ? []
            : [Material(color: Colors.transparent, child: trailing)],
        backgroundColor: backgroundColor ?? Colors.white,
        iconTheme: IconThemeData(
          color: iconColor,
        ),
      );
    } else {
      return AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          title ?? "",
          style: TextStyle(color: textColor),
        ),
        leading: leading != null
            ? Material(color: Colors.transparent, child: leading)
            : null,
        bottom: bottom,
        backgroundColor: backgroundColor ?? Colors.transparent,
      );
    }
  }
}
