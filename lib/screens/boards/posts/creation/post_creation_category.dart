import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/screens/boards/category_type.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

import '../../../../commons/functions_category_boardType.dart';

class PostCreationCategory extends StatefulWidget {
  final Map input;

  PostCreationCategory(this.input);

  @override
  _PostCreationCategoryState createState() => _PostCreationCategoryState();
}

class _PostCreationCategoryState extends State<PostCreationCategory> {
  @override
  void initState() {
    super.initState();
  }

  void setCategory(String category){
    setState(() {
      widget.input['category'] = category;
      widget.input['categoryId'] = transferCategory(category).toString();
    });
  }

  void initCategory(){
    setState(() => widget.input['category'] = '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '카테고리를 선택해주세요.',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              color: GuamColorFamily.grayscaleGray3,
            ),
          ),
          if (widget.input['category'] == '')
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...categoryList.map((c) => _categoryChip(categoryType[c['name']])),
                ],
              ),
            ),
          if (widget.input['category'] != '')
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(
                    "#" + widget.input['category'],
                    style: TextStyle(
                        fontSize: 16, color: GuamColorFamily.blueCore),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () => initCategory(),
                    icon: SvgPicture.asset(
                      'assets/icons/cancel_outlined.svg',
                      color: GuamColorFamily.blueCore,
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _categoryChip(String category) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: false,
        pressElevation: 2,
        labelPadding: EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: GuamColorFamily.purpleLight3,
        onSelected: (e) => setCategory(category),
        label: Text(
          "#" + category,
          style: TextStyle(
            fontSize: 14,
            color: GuamColorFamily.purpleLight1,
          ),
        ),
      ),
    );
  }
}
