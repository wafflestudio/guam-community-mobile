import 'package:flutter/material.dart';

class PostCreationImage extends StatefulWidget {
  final Map input;

  PostCreationImage(this.input);

  @override
  _PostCreationImageState createState() => _PostCreationImageState();
}

class _PostCreationImageState extends State<PostCreationImage> {
  List<dynamic> image;

  @override
  void initState() {
    super.initState();
  }

  void setBoardType(){
    setState(() {
      image = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.input);
    return Container();
  }
}
