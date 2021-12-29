import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/image/image_thumbnail.dart';
import 'package:guam_community_client/helpers/pick_image.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:image_picker/image_picker.dart';

class PostCreationImage extends StatefulWidget {
  final Map input;

  PostCreationImage(this.input);

  @override
  _PostCreationImageState createState() => _PostCreationImageState();
}

class _PostCreationImageState extends State<PostCreationImage> {
  final double maxImgSize = 80;
  final double imgSheetHeight = 96;
  bool sending = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.input['images'].clear();
    super.dispose();
  }

  void setImageFile(PickedFile val) {
    setState(() {
      if (val != null) widget.input['images'].add(val);
    });
  }

  void deleteImageFile(int idx) {
    setState(() => widget.input['images'].removeAt(idx));
  }

  void toggleSending() {
    setState(() => sending = !sending);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            '사진을 첨부해보세요.',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              color: GuamColorFamily.grayscaleGray3,
            )
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: !sending
                    ? () => pickImage(type: 'gallery').then((img) => setImageFile(img))
                    : null,
                child: SizedBox(
                  height: 80,
                  width: 80,
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
                        onPressed: !sending
                            ? () => pickImage(type: 'gallery').then((img) => setImageFile(img))
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              widget.input['images'].isNotEmpty
                  ? SizedBox(
                      height: maxImgSize,
                      width: (maxImgSize + 14.87) * widget.input['images'].length,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.input['images'].length,
                        itemBuilder: (_, idx) =>
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 14.87),
                                  child: ImageThumbnail(
                                    width: maxImgSize,
                                    height: maxImgSize,
                                    image: Image(
                                      image: FileImage(File(widget.input['images'][idx].path)),
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
                                    onPressed: () => deleteImageFile(idx),
                                  ),
                                )
                              ],
                            ),
                      ),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(right: 14.87)),
            ],
          ),
        ),
      ],
    );
  }
}
