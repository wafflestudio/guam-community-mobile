import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../helpers/http_request.dart';

class ImageExpanded extends StatelessWidget{
  final Widget image;
  final String imagePath;

  ImageExpanded({this.image, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: InteractiveViewer(
        child: image ?? FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(HttpRequest().s3BaseAuthority + imagePath),
          fit: BoxFit.fitWidth,
        )
      ),
    );
  }
}
