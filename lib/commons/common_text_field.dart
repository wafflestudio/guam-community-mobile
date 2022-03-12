import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/pick_image.dart';
import 'common_img_nickname.dart';
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
  List<int> mentionTargetIds = [];
  RegExp mentionRegexp = new RegExp(r"@\[__(.*?)__\]"); /// mention할 Id를 마크다운에서 추출하는 정규식

  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();


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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageFileList.isNotEmpty
          ? imgSheetHeight + bottomSheetHeight
          : bottomSheetHeight, // 56 .. 73 .. 90 .. 107
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
                  child: FlutterMentions(
                    key: key,
                    suggestionPosition: SuggestionPosition.Top,
                    style: TextStyle(fontSize: 14),
                    cursorColor: GuamColorFamily.purpleCore,
                    decoration: InputDecoration(
                      hintText: "댓글을 남겨주세요.",
                      hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                    ),
                    mentions: [
                      Mention(
                        trigger: "@",
                        style: TextStyle(color: GuamColorFamily.purpleLight1),
                        data: widget.mentionList,
                        suggestionBuilder: (data) => SingleChildScrollView(
                          dragStartBehavior: DragStartBehavior.start,
                          child: Column(
                            children: [
                              Container(
                                height: 53,
                                padding: EdgeInsets.only(left: 10),
                                color: GuamColorFamily.purpleLight3,
                                child: CommonImgNickname(
                                  fontSize: 13,
                                  imageSize: 41,
                                  profileClickable: false,
                                  nickname: data['display'],
                                  imgUrl: data['photo'] ?? null,
                                ),
                              ),
                              CustomDivider(thickness: 0.5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                !sending
                    ? TextButton(
                      onPressed: () {
                        Iterable<RegExpMatch> matches = mentionRegexp
                            .allMatches(key.currentState.controller.markupText);
                        if (matches.length > 0) {
                          matches.forEach((match) {
                            int mentionId = int.parse(match.group(1));
                            if (!mentionTargetIds.contains(mentionId))
                              mentionTargetIds.add(mentionId);
                          });
                        }
                        /// mentionTargetIds를 request에 담아 같이 보낼 예정.
                        // key.currentState.controller.clear();
                        mentionTargetIds.clear();
                      },
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
