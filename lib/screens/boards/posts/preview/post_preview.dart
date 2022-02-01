import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/app/tab_item.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_home_tab.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_search_tab.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home/home_provider.dart';

class PostPreview extends StatelessWidget {
  final Post post;

  PostPreview(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 12),
        decoration: BoxDecoration(
          color: GuamColorFamily.grayscaleWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                /**
                 * TODO: ryu
                 * Post provider is out of scope in search tab.
                 */
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<Posts>(),
                  child: PostDetail(post),
                )
              )
            );
          },
          child: TabItem.values[context.read<HomeProvider>().idx] == TabItem.search
              ? PostPreviewSearchTab(post)
              : PostPreviewHomeTab(post)
        ),
      ),
    );
  }
}
