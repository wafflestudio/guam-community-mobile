import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/commons/image/image_container.dart';
import 'package:guam_community_client/helpers/pick_image.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:image_picker/image_picker.dart';

class MessageBottomModal extends StatefulWidget {
  final Map input;
  final Function setText;

  MessageBottomModal(this.input, this.setText);

  @override
  _MessageBottomModalState createState() => _MessageBottomModalState();
}

class _MessageBottomModalState extends State<MessageBottomModal> {
  final _messageTextFieldController = TextEditingController();
  Map input;

  @override
  void initState() {
    super.initState();
    input = widget.input;
    input['image'] = [];
  }

  @override
  void dispose() {
    input['image'].clear();
    _messageTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxImgSize = 80;

    Future<void> setImageFile(PickedFile val) async {
      setState(() {
        if (val != null) widget.input['image'].add(val);
      });
    }

    Future<void> deleteImageFile() async {
      setState(() => widget.input['image'].removeAt(0));
    }

    return Container(
      decoration: BoxDecoration(
        color: GuamColorFamily.grayscaleGray7,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: GuamColorFamily.grayscaleGray6, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            controller: _messageTextFieldController,
            onChanged: (e) => widget.setText(e),
            maxLines: 4,
            maxLength: 200,
            style: TextStyle(fontSize: 14, height: 1.6, color: GuamColorFamily.grayscaleGray2),
            decoration: InputDecoration(
              hintText: "내용을 입력해주세요.",
              hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: widget.input['image'].length == 0
                ? SizedBox(
              height: maxImgSize,
              width: maxImgSize,
              child: Container(
                decoration: BoxDecoration(
                  color: GuamColorFamily.grayscaleGray6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset(
                    'assets/icons/plus.svg',
                    color: GuamColorFamily.purpleLight1,
                  ),
                  onPressed: () => pickImage(type: 'gallery')
                      .then((img) => setImageFile(img)),
                ),
              ),
            )
                : Stack(
              children: [
                Container(
                  child: ImageThumbnail(
                    width: maxImgSize,
                    height: maxImgSize,
                    image: Image(
                      image: FileImage(File(widget.input['image'][0].path)),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: IconButton(
                    iconSize: 23,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: SvgPicture.asset('assets/icons/cancel_filled.svg'),
                    onPressed: () => deleteImageFile(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
