import 'package:flutter/material.dart';
import '../common_confirm_dialog.dart';

class BottomModalFunctions extends StatelessWidget {
  final Function customFunction;
  final IconData iconData;
  final String text;
  final String detailText;
  final Color iconColor;
  final Color textColor;
  final Color defaultColor = Colors.black;
  final bool requireConfirm;

  BottomModalFunctions({this.customFunction, this.iconData, this.text,this.detailText, this.iconColor, this.textColor, this.requireConfirm = false});

  @override
  Widget build(BuildContext context) {

    Future _showMyDialog() async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return CommonConfirmDialog(
            dialogText: detailText,
            onPressConfirm: customFunction,
          );
        },
      );
    }

    return InkWell(
      onTap: requireConfirm ? _showMyDialog : customFunction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 13),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Icon(iconData, color: iconColor ?? defaultColor),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textColor ?? defaultColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
