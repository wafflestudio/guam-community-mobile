import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'image_expanded.dart';

class ClosableImageExpanded extends StatelessWidget {
  final Widget image;
  final String imagePath;

  ClosableImageExpanded({this.image, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        trailing: IconButton(
          icon: Icon(Icons.close),
          color: Colors.grey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
      ),
      body: ImageExpanded(
        image: image ?? null,
        imagePath: imagePath ?? null,
      ),
    );
  }
}
