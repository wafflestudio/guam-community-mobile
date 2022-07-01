import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../commons/guam_progress_indicator.dart';
import '../../providers/messages/messages.dart';
import 'message_preview.dart';

class MessageBoxEdit extends StatefulWidget {
  final Function onRefresh;

  MessageBoxEdit({this.onRefresh});

  @override
  State<MessageBoxEdit> createState() => _MessageBoxEditState();
}

class _MessageBoxEditState extends State<MessageBoxEdit> {
  List _messageBoxes = [];
  bool _isFirstLoadRunning = false;

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      await context.read<Messages>().fetchMessageBoxes();
      _messageBoxes = context.read<Messages>().messageBoxes;
    } catch (err) {
      print(err);
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        title: '쪽지함',
        leading: null,
        trailing: Padding(
          padding: EdgeInsets.only(right: 11),
          child: TextButton(
            child: Text(
              '완료',
              style: TextStyle(
                fontSize: 16,
                color: GuamColorFamily.purpleCore,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
              ),
            ),
            onPressed: () {
              widget.onRefresh();
              Navigator.pop(context);
            },
          )
        ),
      ),
      body: _isFirstLoadRunning ? Container(
        color: GuamColorFamily.grayscaleWhite,
        child: Center(child: guamProgressIndicator()),
      ) : Container(
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(top: 18),
        child: Column(
          children: [
            ..._messageBoxes.map((messageBox) => MessagePreview(
              messageBox,
              reload: _firstLoad,
              onRefresh: widget.onRefresh,
              editable: true,
            ))
          ]
        ),
      ),
    );
  }
}
