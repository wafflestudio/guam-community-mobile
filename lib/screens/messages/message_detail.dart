import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_with_alert.dart';
import 'package:guam_community_client/commons/common_text_field.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../commons/guam_progress_indicator.dart';
import '../../providers/user_auth/authenticate.dart';
import 'message_detail_body.dart';

class MessageDetail extends StatefulWidget {
  final List<Message>? messages;
  final Profile? otherProfile;
  final Function? onRefresh;

  MessageDetail(this.messages, this.otherProfile, this.onRefresh);

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  List<Message>? _messages;
  bool commentImageExist = false;
  bool _isFirstLoadRunning = false;

  void addMessageImage() {
    setState(() => commentImageExist = true);
  }

  void removeMessageImage() {
    setState(() => commentImageExist = false);
  }

  void _refreshMsg() async {
    setState(() => _isFirstLoadRunning = true);
    await context.read<Messages>().getMessages(widget.otherProfile!.id);
    _messages = context.read<Messages>().messages;
    setState(() => _isFirstLoadRunning = false);
  }

  @override
  void initState() {
    _refreshMsg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Messages msgProvider = context.read<Messages>();
    Authenticate authProvider = context.read<Authenticate>();

    Future sendMessage({Map<String, dynamic>? fields, List<File>? files}) async {
      bool msgSended = false;
      try {
        await msgProvider.sendMessage(
          fields: fields,
          files: files,
        ).then((successful) {
          if (successful) {
            msgSended = true;
            _refreshMsg(); /// 쪽지 페이지 갱신
            widget.onRefresh!(); /// 쪽지함 페이지 & 안 읽은 쪽지 개수 갱신
          } else {
            print("Error!");
          }
        });
      } catch (e) {
        print(e);
      }
      return msgSended;
    }

    return _isFirstLoadRunning ? Container(
      color: GuamColorFamily.grayscaleWhite,
      child: Center(child: guamProgressIndicator()),
    ) : Portal(
      child: Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          title: widget.otherProfile!.nickname,
          leading: Back(onPressed: widget.onRefresh),
          trailing: Padding(
            padding: EdgeInsets.only(right: 11),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: SvgPicture.asset('assets/icons/more.svg'),
              onPressed: () => showMaterialModalBottomSheet(
                context: context,
                useRootNavigator: true,
                backgroundColor: GuamColorFamily.grayscaleWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => Messages(authProvider)),
                  ],
                  child: Builder(
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(left: 24, top: 24, bottom: 21),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BottomModalWithAlert(
                                funcName: '삭제하기',
                                title: '쪽지함을 삭제하시겠어요?',
                                body: '삭제된 쪽지는 복원할 수 없습니다.',
                                func: () async => await context.read<Messages>()
                                    .deleteMessageBox(widget.otherProfile!.id)
                                    .then((successful) async {
                                  if (successful) {
                                    widget.onRefresh!(); /// 쪽지함 페이지 갱신
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    await context.read<Messages>().fetchMessageBoxes();
                                  }
                                }),
                              ),
                              // BottomModalDefault(
                              //   text: '신고하기',
                              //   onPressed: (){},
                              // ),
                              // BottomModalDefault(
                              //   text: '차단하기',
                              //   onPressed: (){},
                              // ),
                            ],
                          ),
                        ),
                      );
                    }
                  )
                )
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
          onRefresh: () async => _refreshMsg(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    ..._messages!.map((msg) => MessageDetailBody(msg, widget.otherProfile))
                  ]
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.only(bottom: 10),
          color: GuamColorFamily.grayscaleWhite,
          child: CommonTextField(
            messageTo: widget.otherProfile!.id,
            sendButton: '전송',
            onTap: sendMessage,
            mentionList: [],
            addImage: addMessageImage,
            removeImage: removeMessageImage,
            editTarget: null,
          ),
        ),
      ),
    );
  }
}
