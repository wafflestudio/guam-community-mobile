import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../custom_app_bar.dart';
import 'image_expanded.dart';
import 'dart:math';
import 'dart:io' show Platform;

class ImageCarousel extends StatefulWidget {
  final List<dynamic> pictures; /// 서버 수정 후 List<Picture> 로...
  final int initialPage;

  // Actions for trailing
  final bool showImageActions;
  final Function deleteFunc;

  ImageCarousel({@required this.pictures, this.initialPage,
    @required this.showImageActions, this.deleteFunc});

  @override
  State<StatefulWidget> createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  List<dynamic> picturesState; /// 서버 수정 후 List<Picture> 로...
  int currPage;

  @override
  void initState() {
    super.initState();
    picturesState = widget.pictures;
    currPage = widget.initialPage ?? 0;
  }

  void afterDelete() {
    setState(() {
      picturesState.removeAt(currPage);
      currPage = max(currPage - 1, 0);
      if (picturesState.isEmpty) Navigator.of(context).pop(); // pop when delete last image
    });
  }

  void switchPage(int idx) => setState(() {currPage = idx;});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        trailing: IconButton(
          padding: EdgeInsets.only(right: 12),
          constraints: BoxConstraints(),
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/cancel_outlined.svg',
            color: GuamColorFamily.grayscaleWhite,
            width: 32,
            height: 32,
          ),
        ),
        // trailing: widget.showImageActions ? IconButton(
        //   icon: Icon(Icons.more_vert),
        //   color: Colors.grey,
        //   onPressed: () {
        //     if (Platform.isAndroid) {
        //       showMaterialModalBottomSheet(
        //           context: context,
        //           builder: (_) => BottomModalContent(
        //               deleteText: "이미지 삭제",
        //               deleteFunc: () async {
        //                 await widget.deleteFunc(imageId: picturesState[currPage].id)
        //                     .then((successful) {
        //                   if (successful) {
        //                     Navigator.of(context).pop(); // pop Modal Bottom Content
        //                     afterDelete();
        //                   }
        //                 });
        //               }
        //           )
        //       );
        //     } else {
        //       showCupertinoModalBottomSheet(
        //           context: context,
        //           builder: (_) => BottomModalContent(
        //               deleteText: "이미지 삭제",
        //               deleteFunc: () async {
        //                 await widget.deleteFunc(imageId: picturesState[currPage].id)
        //                     .then((successful) {
        //                   if (successful) {
        //                     Navigator.of(context).pop(); // pop Modal Bottom Content
        //                     afterDelete();
        //                   }
        //                 });
        //               }
        //           )
        //       );
        //     }
        //   },
        // ) : null,
      ),
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              scrollPhysics: ClampingScrollPhysics(),
              initialPage: currPage,
              onPageChanged: (idx, _) => switchPage(idx)
            ),
            /// 서버 수정 후 e가 아니라 e.urlPath 로...
            items: [...picturesState.map((e) => ImageExpanded(imagePath: e))]
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.65),
              child: Container(
                width: 49,
                height: 25,
                decoration: BoxDecoration(
                  color: GuamColorFamily.grayscaleGray3,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.only(left: 12, top: 5, right: 12, bottom: 2),
                child: Text(
                  '${currPage+1} / ${picturesState.length}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
