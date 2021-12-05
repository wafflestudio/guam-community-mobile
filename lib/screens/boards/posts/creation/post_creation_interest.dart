import 'package:flutter/material.dart';

class PostCreationInterest extends StatefulWidget {
  final Map input;

  PostCreationInterest(this.input);

  @override
  _PostCreationInterestState createState() => _PostCreationInterestState();
}

class _PostCreationInterestState extends State<PostCreationInterest> {
  String interest;

  @override
  void initState() {
    super.initState();
  }

  void setBoardType(){
    setState(() {
      interest = '데이터분석';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.input);
    return Container();
  }
}
