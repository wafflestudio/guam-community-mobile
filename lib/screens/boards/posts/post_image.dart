import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/image/image_container.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:guam_community_client/styles/colors.dart';

class PostImage extends StatelessWidget {
  final String picture; /// 추후 String -> Picture model로...
  final bool blur;
  final int hiddenImgCnt;

  PostImage({this.picture, this.blur, this.hiddenImgCnt});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: IgnorePointer(
            ignoring: true,
            child: ImageThumbnail(
              imagePath: picture, /// 추후 picture.urlPath 로...
              height: 100,
              width: 100,
            ),
          ),
        ),
        if (blur)
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(120, 120, 120, 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        if (blur)
          Center(
            child: Text(
              "+ $hiddenImgCnt",
              style: TextStyle(
                fontSize: 12,
                color: GuamColorFamily.grayscaleWhite,
              ),
            ),
          )
      ],
    );
  }
}
