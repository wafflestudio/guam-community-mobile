import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

mixin Toast {
  void showToast ({@required bool success, @required String msg}) {
    BotToast.showText(
      text: msg ?? (success ? "완료되었습니다" : "오류가 발생했습니다"),
      contentColor: success
          ? Color.fromRGBO(85, 88, 255, 1)
          : Color.fromRGBO(235, 87, 87, 1),
      borderRadius: BorderRadius.circular(30),
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.white
      )
    );
  }
}
