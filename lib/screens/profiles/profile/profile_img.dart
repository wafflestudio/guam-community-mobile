import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/image/closable_image_expanded.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../commons/image/image_container.dart';

class ProfileImg extends StatefulWidget {
  final String profileImg;
  final double height;
  final double width;
  final List<dynamic> newImage;

  ProfileImg({this.profileImg, this.height, this.width, this.newImage});

  @override
  State<ProfileImg> createState() => _ProfileImgState();
}

class _ProfileImgState extends State<ProfileImg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.profileImg != null ? Colors.transparent : Colors.grey,
      ),
      child: ClipOval(
        child: widget.profileImg == null
            ? widget.newImage != null && widget.newImage.isNotEmpty
                ? Container( /// 프사 설정 안 된 상태에서 사진첩에서 사진 불러옴.
                    child: ImageThumbnail(
                      width: widget.width,
                      height: widget.height,
                      image: Image(
                        image: FileImage(File(widget.newImage[0].path)),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Image( /// 프사가 아예 없거나 기본 사진으로 설정 버튼 누름.
                    image: SvgProvider('assets/icons/profile_image.svg'),
                    width: widget.width,
                    height: widget.height,
                  )
            : widget.newImage != null && widget.newImage.isNotEmpty
                ? Container( /// 프사 설정된 상태에서 사진첩에서 사진 불러옴.
                    child: ImageThumbnail(
                      width: widget.width,
                      height: widget.height,
                      image: Image(
                        image: FileImage(File(widget.newImage[0].path)),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : InkWell( /// 프사 설정된 상태에서 아무 작업도 안 함.
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(HttpRequest().s3BaseAuthority + widget.profileImg),
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (_) => ClosableImageExpanded(
                          imagePath: widget.profileImg,
                        )),
                      );
                    }
                  )
      ),
    );
  }
}
