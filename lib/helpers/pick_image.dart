import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<PickedFile> pickImage({@required type}) async {
  final ImagePicker picker = ImagePicker();
  switch (type) {
    case 'gallery':
      return await picker.getImage(source: ImageSource.gallery, imageQuality: 30);
      break;
    case 'camera':
      return await picker.getImage(source: ImageSource.camera, imageQuality: 30);
      break;
    default:
      print("We can pick images from either gallery or camera.");
      return null;
  }
}
