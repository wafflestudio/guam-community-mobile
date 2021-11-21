import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'common_icon_button.dart';
import 'image_thumbnail.dart';

class CommonImageField extends StatefulWidget {

  @override
  _CommonImageFieldState createState() => _CommonImageFieldState();
}

class _CommonImageFieldState extends State<CommonImageField> {
  final double maxImgSize = 80;
  final double deleteImgButtonRadius = 12;
  List<PickedFile> imageFileList = [];

  @override
  void dispose() {
    imageFileList.clear();
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

  @override
  Widget build(BuildContext context) {
    print(imageFileList);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      imageFileList.isNotEmpty ?
      Container(
        // color: Colors.transparent,
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
      )
      : Container(),
    );
  }
}
