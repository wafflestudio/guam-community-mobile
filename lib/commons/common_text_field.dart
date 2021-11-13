import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../helpers/pick_image.dart';
import 'image_thumbnail.dart';
import 'common_icon_button.dart';
import 'button_size_circular_progress_indicator.dart';

class CommonTextField extends StatefulWidget {
  final Function onTap;
  final dynamic editTarget;
  final bool allowImages;

  CommonTextField({@required this.onTap, this.editTarget, this.allowImages = true});

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _threadTextFieldController = TextEditingController();
  final double maxImgSize = 80;
  final double deleteImgButtonRadius = 12;
  List<PickedFile> imageFileList = [];
  bool sending = false;

  @override
  void dispose() {
    imageFileList.clear();
    _threadTextFieldController.dispose();
    super.dispose();
  }

  void setImageFile(PickedFile val) {
    setState(() {
      if (val != null) imageFileList.add(val);
    });
  }

  void deleteImageFile(int idx) {
    setState(() {
      imageFileList.removeAt(idx);
    });
  }

  void toggleSending() {
    setState(() {
      sending = !sending;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.editTarget != null;
    _threadTextFieldController.text = isEdit ? widget.editTarget.content : null;

    Future<void> send() async {
      toggleSending();

      try {
        if (isEdit) {
          await widget.onTap(
            id: widget.editTarget.id,
            fields: {"content": _threadTextFieldController.text},
          ).then((successful) {
            if (successful) {
              _threadTextFieldController.clear();
              FocusScope.of(context).unfocus();
            }
          });
        } else {
          await widget.onTap(
            files: [...imageFileList.map((e) => File(e.path))],
            fields: {"content": _threadTextFieldController.text},
          ).then((successful) {
            if (successful) {
              imageFileList.clear();
              _threadTextFieldController.clear();
              FocusScope.of(context).unfocus();
            }
          });
        }
      } catch (e) {
        print(e);
      } finally {
        toggleSending();
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, -2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (!isEdit && widget.allowImages) Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/camera.svg'),
                  onPressed: !sending
                      ? () {
                    pickImage(type: 'gallery').then((img) =>
                        setImageFile(img));
                  }
                      : null,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                if (imageFileList.isNotEmpty) Container(
                  constraints: BoxConstraints(maxHeight: maxImgSize + deleteImgButtonRadius),
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageFileList.length,
                    itemBuilder: (_, idx) =>
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: deleteImgButtonRadius,
                              right: deleteImgButtonRadius,
                            ),
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
                            top: 0,
                            right: 0,
                            child: CommonIconButton(
                              icon: Icons.remove_circle,
                              iconColor: Colors.red,
                              onPressed: () => deleteImageFile(idx),
                            ),
                          )
                        ],
                      ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _threadTextFieldController,
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
                      contentPadding: EdgeInsets.only(top: 18, bottom: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          !sending ? TextButton(
            // autofocus: true,
            onPressed: () {},
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 16)),
            ),
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
    );
  }
}
