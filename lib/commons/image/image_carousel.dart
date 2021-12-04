import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:guam_community_client/styles/colors.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../custom_app_bar.dart';
import 'image_expanded.dart';
// import 'bottom_modal/bottom_modal_content.dart';
import 'dart:math';
import 'dart:io' show Platform;

class ImageCarousel extends StatefulWidget {
  final List<Picture> pictures;
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
  List<Picture> picturesState;
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
      body: CarouselSlider(
          options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              initialPage: currPage,
              onPageChanged: (idx, _) => switchPage(idx)
          ),
          items: [...picturesState.map((e) => ImageExpanded(imagePath: e.urlPath))]
      ),
    );
  }
}
