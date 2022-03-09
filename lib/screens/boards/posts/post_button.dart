import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../../providers/posts/posts.dart';
import 'creation/post_creation.dart';

class PostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: GuamColorFamily.purpleCore,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/write.svg',
              color: GuamColorFamily.grayscaleWhite,
              width: 30,
              height: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: context.read<Posts>(),
                    child: PostCreation(),
                  )
                )
              );
            }
          ),
        ),
      ),
    );
  }
}
