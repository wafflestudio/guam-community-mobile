import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:transparent_image/transparent_image.dart';
import 'closable_image_expanded.dart';

class ImageThumbnail extends StatelessWidget {
  /*
  * image: for uploaded native image file via ImagePicker, etc.,
  * imagePath: for network image path (S3)
  * IMPORTANT: only 1 of above should be passed to parameter
  * */
  final Widget? image;
  final String? imagePath;
  final double? height;
  final double? width;

  ImageThumbnail({this.image, this.imagePath, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image ?? FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(HttpRequest().s3BaseAuthority + imagePath!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (_) => ClosableImageExpanded(
            image: image ?? null,
            imagePath: imagePath ?? null
          )
        )
      )
    );
  }
}
