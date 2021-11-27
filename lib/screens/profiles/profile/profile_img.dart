import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/image/closable_image_expanded.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileImg extends StatelessWidget {
  final Picture profileImg;

  ProfileImg(this.profileImg);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: profileImg != null ? Colors.transparent : Colors.grey,
      ),
      child: ClipOval(
          child: profileImg.urlPath != null
              ? InkWell(
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(profileImg.urlPath),
                  fit: BoxFit.cover
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ClosableImageExpanded(imagePath: profileImg.urlPath))
                  );
                }
          ) : Image(image: SvgProvider('assets/icons/profile_image.svg'))
      ),
    );
  }
}
