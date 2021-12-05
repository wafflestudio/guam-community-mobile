import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostCreationImage extends StatefulWidget {
  final Map input;

  PostCreationImage(this.input);

  @override
  _PostCreationImageState createState() => _PostCreationImageState();
}

class _PostCreationImageState extends State<PostCreationImage> {
  @override
  void initState() {
    super.initState();
  }

  void setImages(){
    setState(() {
      widget.input['images'] = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
              '사진을 첨부해보세요.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray3,
              )
          ),
        ),
      ],
    );
  }
}
