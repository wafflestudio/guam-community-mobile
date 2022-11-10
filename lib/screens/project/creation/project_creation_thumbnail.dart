import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/image/image_thumbnail.dart';
import 'package:guam_community_client/helpers/pick_image.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProjectCreationThumbnail extends StatefulWidget {
  final Map input;

  ProjectCreationThumbnail(this.input);

  @override
  _ProjectCreationThumbnailState createState() => _ProjectCreationThumbnailState();
}

class _ProjectCreationThumbnailState extends State<ProjectCreationThumbnail> {
  late Map input;
  final double maxImgSize = 80;
  final double imgSheetHeight = 96;
  bool sending = false;

  @override
  void initState() {
    super.initState();
    input = widget.input;
    input['thumbnail'] = [];
  }

  @override
  void dispose() {
    input['thumbnail'].clear();
    super.dispose();
  }

  void toggleSending() {
    setState(() => sending = !sending);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> setImageFile(PickedFile? val) async {
      setState(() {
        if (val != null) widget.input['thumbnail'].add(val);
      });
    }

    Future<void> deleteImageFile() async {
      setState(() => widget.input['thumbnail'].removeAt(0));
    }

    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Container(
        width: double.infinity,
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(left: 15, top: 14, right: 15, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '사진을 첨부해보세요.',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: GuamColorFamily.grayscaleGray3,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 16),
              child: widget.input['thumbnail'].length == 0
                  ? SizedBox(
                      height: maxImgSize,
                      width: maxImgSize,
                      child: DottedBorder(
                        strokeWidth: 1,
                        dashPattern: [4, 5],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: GuamColorFamily.purpleLight2,
                        child: Center(
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
                      ),
                    )
                  : Stack(
                      children: [
                        Container(
                          child: ImageThumbnail(
                            width: maxImgSize,
                            height: maxImgSize,
                            image: Image(
                              image: FileImage(File(widget.input['thumbnail'][0].path)),
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
                            icon:
                                SvgPicture.asset('assets/icons/cancel_filled.svg'),
                            onPressed: () => deleteImageFile(),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
