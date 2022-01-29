import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostCreationInterest extends StatefulWidget {
  final Map input;
  final bool isBoardAnonymous;

  PostCreationInterest(this.input, this.isBoardAnonymous);

  @override
  _PostCreationInterestState createState() => _PostCreationInterestState();
}

class _PostCreationInterestState extends State<PostCreationInterest> {
  @override
  void initState() {
    super.initState();
  }

  void setInterest(String interest){
    setState(() => widget.input['interest'] = interest);
  }

  void initInterest(){
    setState(() => widget.input['interest'] = '');
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isBoardAnonymous) {
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
                )
            ),
            if (widget.input['interest'] == '')
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _interestChip('개발'),
                    _interestChip('데이터분석'),
                    _interestChip('디자인'),
                    _interestChip('기획/마케팅'),
                    _interestChip('기타'),
                  ],
                ),
              ),
            if (widget.input['interest'] != '')
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Text(
                      "#" + widget.input['interest'],
                      style: TextStyle(
                          fontSize: 16, color: GuamColorFamily.blueCore),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () => initInterest(),
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
    } else {
      return Container();
    }
  }

  Widget _interestChip(String interest) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: false,
        pressElevation: 2,
        labelPadding: EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: GuamColorFamily.purpleLight3,
        onSelected: (e) => setInterest(interest),
        label: Text(
          "#" + interest,
          style: TextStyle(
            fontSize: 14,
            color: GuamColorFamily.purpleLight1,
          ),
        ),
      ),
    );
  }
}
