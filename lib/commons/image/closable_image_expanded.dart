import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../custom_app_bar.dart';
import 'image_expanded.dart';

class ClosableImageExpanded extends StatelessWidget {
  final Widget? image;
  final String? imagePath;

  ClosableImageExpanded({this.image, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        trailing: IconButton(
          padding: EdgeInsets.only(right: 12),
          constraints: BoxConstraints(),
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/cancel_outlined.svg',
            color: GuamColorFamily.grayscaleWhite,
            width: 32,
            height: 32,
          ),
        ),
      ),
      body: ImageExpanded(
        image: image ?? null,
        imagePath: imagePath ?? null,
      ),
    );
  }
}
