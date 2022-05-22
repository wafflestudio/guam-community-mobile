import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/models/messages/message_box.dart' as MessageBox;
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/screens/messages/message_box_edit.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';

import '../../commons/guam_progress_indicator.dart';
import 'message_preview.dart';

class MessageBody extends StatefulWidget {
  final List<MessageBox.MessageBox> messageBoxes;

  MessageBody(this.messageBoxes);

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  List _messageBoxes = [];
  bool _isFirstLoadRunning = false;
  ScrollController _scrollController = ScrollController();

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      await context.read<Messages>().fetchMessageBoxes();
      _messageBoxes = context.read<Messages>().messageBoxes;
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  @override
  void initState() {
    _firstLoad();
    // _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        title: '쪽지함',
        leading: Back(),
        trailing: Padding(
          padding: EdgeInsets.only(right: 14),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset('assets/icons/delete_outlined.svg'),
            onPressed: (_messageBoxes == null || _messageBoxes.isEmpty)
                ? null
                : () => Navigator.of(context, rootNavigator: true).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MessageBoxEdit(_messageBoxes),
                  transitionDuration: Duration(seconds: 0),
                )
            ),
          ),
        ),
      ),
      body: _isFirstLoadRunning
          ? Center(child: guamProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => _firstLoad(),
              color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
              child: Container(
                height: double.infinity,
                color: GuamColorFamily.grayscaleWhite,
                padding: EdgeInsets.only(top: 18),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      if (_messageBoxes == null || _messageBoxes.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                            child: Text(
                              '쪽지함이 비어있습니다.',
                              style: TextStyle(
                                fontSize: 16,
                                color: GuamColorFamily.grayscaleGray4,
                                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                              ),
                            ),
                          ),
                        ),
                      if (_messageBoxes != null && _messageBoxes.isNotEmpty)
                        ..._messageBoxes.map((messageBox) => MessagePreview(messageBox)
                      )
                    ]
                  ),
                ),
              ),
            ),
    );
  }
}
