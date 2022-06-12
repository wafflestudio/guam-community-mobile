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
      padding: EdgeInsets.only(bottom: 72),
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Center(
        child: Container(
          width: double.infinity,
          child: InteractiveViewer(
            child: image ?? FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(HttpRequest().s3BaseAuthority + imagePath),
              fit: BoxFit.fitWidth,
            )
          ),
        ),
      ),
    );
  }
}
