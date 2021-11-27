import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<PickedFile> pickImage({@required type}) async {
  final ImagePicker picker = ImagePicker();
  switch (type) {
    case 'gallery':
      return await picker.getImage(source: ImageSource.gallery);
      break;
    case 'camera':
      return await picker.getImage(source: ImageSource.camera);
      break;
    default:
      print("We can pick images from either gallery or camera.");
      return null;
  }
}
