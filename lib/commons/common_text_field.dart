import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/mention_list.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/pick_image.dart';
import 'image/image_thumbnail.dart';
import 'button_size_circular_progress_indicator.dart';

class CommonTextField extends StatefulWidget {
  final String sendButton;
  final Function onTap;
  final Function addCommentImage;
  final Function removeCommentImage;
  final dynamic editTarget;
  final List<Map<String, dynamic>> mentionList;

  CommonTextField({this.sendButton='등록', @required this.onTap, this.addCommentImage, this.removeCommentImage, this.editTarget, this.mentionList});

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _commentTextFieldController = TextEditingController();
  final double maxImgSize = 80;
  final double imgSheetHeight = 96;
  double mentionTargetHeight = 160;
  double bottomSheetHeight = 56;
  bool sending = false;
  bool activeMention = false;
  List<PickedFile> imageFileList = [];
  List<Set> mentionTarget = [];

  @override
  void initState() {
    _commentTextFieldController.text = '';
    super.initState();
  }
  @override
  void dispose() {
    imageFileList.clear();
    _commentTextFieldController.dispose();
    super.dispose();
  }

  void setImageFile(PickedFile val) {
    setState(() {
      if (val != null) imageFileList.add(val);
    });
  }

  void deleteImageFile(int idx) {
    setState(() => imageFileList.removeAt(idx));
  }

  void toggleSending() {
    setState(() => sending = !sending);
  }

  void heightOfImageOrMention(bool activeMention, bool activeImage){
    setState(() => activeMention
        ? mentionTargetHeight = 160 : mentionTargetHeight = 0
    );
  }

  /// 멘션 관련
  void activateMention() {
    String _text = _commentTextFieldController.text;

    setState(() {
      if (_text.length > 0) {
        // 가장 마지막 글자가 @인 경우 Mention 활성화
        _text.substring(_text.length - 1, _text.length) == '@'
            ? activeMention = true
            : activeMention = false;
      } else {
        // 텍스트 처음 값으로 @ 입력 후 해당 @를 지울 때 Mention 비활성화
        activeMention = false;
      }
    });
  }

  /// 멘션 관련
  void setMentionTarget(int id, String nickname) {
    String _text = _commentTextFieldController.text;

    setState(() {
      activeMention = false;
      mentionTarget.add({id, nickname});
      mentionTarget = mentionTarget.toSet().toList();

      // mention 리스트에서 프로필 선택 시 채팅창에 @nickname이 추가되므로,함
      // @를 입력하여 시작한 경우 @가 중복되는 것을 막기 위한 로직
      if (_text != null && _text.length > 0) {
        if (_text.substring(_text.length - 1, _text.length) == '@'){
          _text = _text.substring(0, _text.length - 1);
        }
      }
      _commentTextFieldController.text = _text + '@$nickname';
    });
  }

  @override
  Widget build(BuildContext context) {
    // text cursor 맨 앞이 아닌 뒤로 보내주도록
    _commentTextFieldController.selection = TextSelection.fromPosition(
      TextPosition(offset: _commentTextFieldController.text.length),
    );

    // count the number of TextField lines for controlling a bottom Sheet
    final span = TextSpan(text:_commentTextFieldController.text);
    final tp = TextPainter(text:span,maxLines: 1,textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width - (56 + 62));
    List<LineMetrics> lines = tp.computeLineMetrics();
    int numberOfLines = lines.length;

    void heightOfBottomSheet(int numberOfLines){
      setState(() {
        if (numberOfLines == 1) bottomSheetHeight = 56;
        if (numberOfLines == 2) bottomSheetHeight = 73;
        if (numberOfLines == 3) bottomSheetHeight = 90;
        if (numberOfLines == 4) bottomSheetHeight = 107;
      });
    }

    /// Mention 관련
    if (widget.mentionList != null && _commentTextFieldController.text.contains('@')) {
      if (_commentTextFieldController.text.substring(
          _commentTextFieldController.text.length - 1,
          _commentTextFieldController.text.length) == '@'
      ) {
        // 텍스트에 @가 존재하고 스페이스를 입력하지 않고, 멘션 리스트를 선택할 수 있는 경우
        heightOfImageOrMention(true, imageFileList.isNotEmpty);
      } else {
        // 텍스트에 @가 존재하지만 스페이스 등을 통해 annotation 범위를 벗어나 멘션 리스트를 보이지 않게 하는 경우
        heightOfImageOrMention(false, imageFileList.isNotEmpty);
      }
    } else {
      // 텍스트에 아예 @가 없는 경우 (초기 세팅)
      heightOfImageOrMention(false, imageFileList.isNotEmpty);
    }

    // bool isEdit = widget.editTarget != null;
    // _commentTextFieldController.text = isEdit ? widget.editTarget.content : null;

    // if (imageFileList.isNotEmpty) {
    //   widget.addCommentImage();
    // } else {
    //   widget.removeCommentImage();
    // }
    // Future<void> send() async {
    //   toggleSending();
    //
    //   try {
    //     if (isEdit) {
    //       await widget.onTap(
    //         id: widget.editTarget.id,
    //         fields: {"content": _commentTextFieldController.text},
    //       ).then((successful) {
    //         if (successful) {
    //           _commentTextFieldController.clear();
    //           FocusScope.of(context).unfocus();
    //         }
    //       });
    //     } else {
    //       await widget.onTap(
    //         files: [...imageFileList.map((e) => File(e.path))],
    //         fields: {"content": _commentTextFieldController.text},
    //       ).then((successful) {
    //         if (successful) {
    //           imageFileList.clear();
    //           _commentTextFieldController.clear();
    //           FocusScope.of(context).unfocus();
    //         }
    //       });
    //     }
    //   } catch (e) {
    //     print(e);
    //   } finally {
    //     toggleSending();
    //   }
    // }

    return SizedBox(
      height: imageFileList.isNotEmpty
          ? mentionTargetHeight > 0 //
              ? bottomSheetHeight + mentionTargetHeight
              : imgSheetHeight + bottomSheetHeight + mentionTargetHeight
          : bottomSheetHeight + mentionTargetHeight,
            // bottomSheetHeight : 56 .. 73 .. 90 .. 107
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: GuamColorFamily.grayscaleWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                imageFileList.isNotEmpty
                    ? Container(
                        color: GuamColorFamily.grayscaleGray1.withOpacity(0.4),
                        padding: EdgeInsets.only(left: 23, top: 8, bottom: 8),
                        constraints: BoxConstraints(maxHeight: maxImgSize + 15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageFileList.length,
                          itemBuilder: (_, idx) => Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 14.87),
                                child: ImageThumbnail(
                                  width: maxImgSize,
                                  height: maxImgSize,
                                  image: Image(
                                    image: FileImage(File(imageFileList[idx].path)),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 2,
                                right: 14,
                                child: IconButton(
                                  iconSize: 23,
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: SvgPicture.asset('assets/icons/cancel_filled.svg'),
                                  onPressed: () {
                                    deleteImageFile(idx);
                                    if (imageFileList.isEmpty) widget.removeCommentImage();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                /// 멘션 관련
                if (activeMention)
                  MentionField(widget.mentionList, setMentionTarget),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: IconButton(
                    iconSize: 24,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: SvgPicture.asset('assets/icons/camera.svg'),
                    onPressed: !sending
                        ? () => pickImage(type: 'gallery').then((img) {
                          setImageFile(img);
                          widget.addCommentImage();
                        })
                        : null,
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _commentTextFieldController,
                    maxLines: 4,
                    minLines: 1,
                    style: TextStyle(fontSize: 14),
                    cursorColor: GuamColorFamily.purpleCore,
                    onChanged: (e) {
                      heightOfBottomSheet(numberOfLines);
                      /// 멘션 관련
                      // 쪽지함에서는 멘션 기능 없음.
                      if (widget.mentionList != null) activateMention();
                    },
                    decoration: InputDecoration(
                      hintText: "댓글을 남겨주세요.",
                      hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 18, bottom: 20),
                    ),
                  ),
                ),
                !sending
                    ? TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(right: 6),
                        minimumSize: Size(30, 26),
                        alignment: Alignment.center,
                      ),
                      child: Text(
                        widget.sendButton,
                        style: TextStyle(
                          color: GuamColorFamily.purpleCore,
                          fontSize: 16,
                        ),
                      ),
                    )
                    : ButtonSizeCircularProgressIndicator()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
