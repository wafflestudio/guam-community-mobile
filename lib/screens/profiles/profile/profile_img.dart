import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/image/closable_image_expanded.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileImg extends StatelessWidget {
  final Picture profileImg;
  final double height;
  final double width;

  ProfileImg({this.profileImg, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: profileImg != null ? Colors.transparent : Colors.grey,
      ),
      child: ClipOval(
        child: profileImg != null
            ? InkWell(
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(profileImg.urlPath),
                fit: BoxFit.cover
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (_) => ClosableImageExpanded(
                    imagePath: profileImg.urlPath),
                  )
                );
              }
        ) : Image(image: SvgProvider('assets/icons/profile_image.svg'))
      ),
    );
  }
}
