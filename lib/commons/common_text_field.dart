import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../helpers/pick_image.dart';
import 'image_thumbnail.dart';
import 'button_size_circular_progress_indicator.dart';

class CommonTextField extends StatefulWidget {
  final Function onTap;
  final dynamic editTarget;

  CommonTextField({@required this.onTap, this.editTarget});

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _commentTextFieldController = TextEditingController();
  final double maxImgSize = 80;
  bool sending = false;
  List<PickedFile> imageFileList = [];

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
    bool isEdit = widget.editTarget != null;
    _commentTextFieldController.text = isEdit ? widget.editTarget.content : null;

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
          ? 152 // 96 + 56
          : 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: GuamColorFamily.grayscaleWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            imageFileList.isNotEmpty
            ? Container(
              color: GuamColorFamily.grayscaleGray1.withOpacity(0.4),
              padding: EdgeInsets.only(left: 23, top: 8, bottom: 8),
              constraints: BoxConstraints(maxHeight: maxImgSize + 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageFileList.length,
                itemBuilder: (_, idx) =>
                  Stack(
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
                        top: 4,
                        right: 18,
                        child: IconButton(
                          iconSize: 18,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: SvgPicture.asset('assets/icons/cancel_filled.svg'),
                          onPressed: () => deleteImageFile(idx),
                        ),
                      )
                    ],
                  ),
              ),
            )
            : Container(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isEdit) Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: IconButton(
                    iconSize: 24,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: SvgPicture.asset('assets/icons/camera.svg'),
                    onPressed: !sending
                        ? () => pickImage(type: 'gallery').then((img) =>
                        setImageFile(img))
                        : null,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _commentTextFieldController,
                    maxLines: null,
                    style: TextStyle(fontSize: 14),
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
                      child: Text(
                        '등록',
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
