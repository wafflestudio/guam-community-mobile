import 'package:flutter/material.dart';

class CommonConfirmDialog extends StatelessWidget {
  final String dialogText;
  final String confirmText;
  final String declineText;
  final Function onPressConfirm;
  final Function onPressDecline;

  CommonConfirmDialog({@required this.dialogText, confirmText = "확인",
    declineText = "취소", this.onPressConfirm, this.onPressDecline})
      : this.confirmText = confirmText, this.declineText = declineText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(Icons.notifications_none, size: 16),
            Text(" 알림", style: TextStyle(fontSize: 12))
          ]
        )
      ),
      contentPadding: EdgeInsets.all(10),
      content: Text(
        dialogText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.black)
      ),
      actions: [
        TextButton(
          child: Text(
            confirmText,
            style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(85, 88, 255, 1),
            )
          ),
          onPressed: () {
            // 일단은 dialog 2개 연달아 띄우는 tutorial을 위해 순서 유지
            Navigator.of(context).pop();
            if (onPressConfirm != null) onPressConfirm();
          },
        ),
        TextButton(
          child: Text(
            declineText,
            style: TextStyle(fontSize: 14, color: Colors.red)
          ),
          onPressed: () {
            // 일단은 dialog 2개 연달아 띄우는 tutorial을 위해 순서 유지
            Navigator.of(context).pop();
            if (onPressDecline != null) onPressDecline();
          },
        ),
      ],
    );
  }
}
