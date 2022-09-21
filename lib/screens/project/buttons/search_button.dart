import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchButton extends StatelessWidget {

  SearchButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: IconButton(
          icon: SvgPicture.asset(
              'assets/icons/search.svg'
          ),
          onPressed: () {
            // 검색창으로 이동
          }
      ),
    );
  }


}