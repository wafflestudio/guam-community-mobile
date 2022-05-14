import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/app/tab_item.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_home_tab.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_search_tab.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home/home_provider.dart';
import '../../../../providers/user_auth/authenticate.dart';

class PostPreview extends StatelessWidget with Toast {
  final Post post;

  PostPreview(this.post);

  @override
  Widget build(BuildContext context) {
    Posts postProvider = context.read<Posts>();
    Authenticate authProvider = context.read<Authenticate>();

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
                builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => Posts(authProvider)),
                  ],
                  child: FutureBuilder(
                    future: postProvider.getPost(post.id),
                    builder: (_, AsyncSnapshot<Post> snapshot) {
                      if (snapshot.hasData) {
                        return PostDetail(snapshot.data);
                      } else if (snapshot.hasError) {
                        Navigator.pop(context);
                        postProvider.fetchPosts(0);
                        showToast(success: false, msg: '게시글을 찾을 수 없습니다.');
                        return null;
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                  ),
                ),
              ),
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
