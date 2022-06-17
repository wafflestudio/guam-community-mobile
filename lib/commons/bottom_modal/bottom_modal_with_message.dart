import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/messages/message_bottom_modal.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/messages/messages.dart';

class BottomModalWithMessage extends StatefulWidget {
  final String funcName;
  final String title;
  final Profile profile;
  final Function func;

  BottomModalWithMessage({this.funcName, this.title, this.profile, this.func});

  @override
  State<BottomModalWithMessage> createState() => _BottomModalWithMessageState();
}

class _BottomModalWithMessageState extends State<BottomModalWithMessage> with Toast {
  Map input = {'text': '', 'image': []}; // image

  @override
  Widget build(BuildContext context) {
    bool sending = false;
    final msgProvider = context.read<Messages>();

    void toggleSending() {
      setState(() => sending = !sending);
    }

    void setText(String textMsg){
      setState(() => input['text'] = textMsg);
    }

    Future sendMessage({List<File> files}) async {
      toggleSending();
      try {
        if (input['text'] == '' && files.isEmpty) {
          showToast(success: false, msg: '쪽지를 작성해주세요.');
          return null;
        }
          await msgProvider.sendMessage(
          fields: {
            'to': widget.profile.id.toString(),
            'text': input['text'] == '' && files.isNotEmpty ? '사진' : input['text'],
            // 서버 수정 전까지 사진만 달랑 보내는 경우 텍스트를 '사진'으로 지정하여 전송.
          },
          files: files,
        ).then((successful) {
          toggleSending();
          if (successful) {
            Navigator.maybePop(context);
          } else {
            print("Error!");
            // showToast(success: false, msg: '쪽지를 발송할 수 없습니다.');
          }
        });
      } catch (e) {
        print(e);
      }
    }

    return Container(
      padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
      decoration: BoxDecoration(
        color: GuamColorFamily.grayscaleWhite,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
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
          Padding(padding: EdgeInsets.only(bottom: 14)),
          MessageBottomModal(input, setText),
          Padding(padding: EdgeInsets.only(bottom: 14)),
          !sending ? Center(
            child: TextButton(
              onPressed: !sending
                  ? () async => await sendMessage(
                    files: input['image'] != []
                        ? [...input['image'].map((e) => File(e.path))]
                        : [])
                  : null,
              child: Text(
                widget.funcName,
                style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore),
              ),
            ),
          ) : Center(
              child: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(top: 13, bottom: 15),
                child: CircularProgressIndicator(
                  color: GuamColorFamily.purpleLight1,
                ),
              ),
          ),
        ],
      ),
    );
  }
}
