import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../commons/icon_text.dart';

class SearchAppTextField extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GuamColorFamily.grayscaleGray6,
      ),
      child: Row(
        children: [
          IconText(
            iconSize: 15,
            iconColor: GuamColorFamily.grayscaleGray3,
            iconPath: 'assets/icons/search.svg',
          ),
          // Expanded(child: SearchAppTextField())
        ],
      ),
    );
  }
}
