import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart' as share_plus;

class Share with Toast {
  String? title;
  BuildContext context;
  bool isLoading = false;

  Share({this.title="", required this.context});

  Future<bool> initialize() async {
    bool dynamicLinkExists = await _getInitialLink();
    _addListener();

    return dynamicLinkExists;
  }

  Future<bool> _getInitialLink() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      _navigateScreen(initialLink.link.path);
      return true;
    }

    return false;
  }

  void addListener(Function function) {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      function();
    }).onError((e) {
      print(e);
    });
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _navigateScreen(dynamicLinkData.link.path);
    }).onError((e) {
      print(e);
    });
  }

  void _navigateScreen(String dynamicLink) {
    Authenticate authProvider = context.read<Authenticate>();
    Posts postProvider = Posts(authProvider);
    String postId = dynamicLink.split('/').last;
    // 페이지 이동
    Navigator.of(context,).push(
      MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Posts(authProvider)),
            ChangeNotifierProvider(create: (_) => Messages(authProvider)),
          ],
          child: FutureBuilder(
            future: postProvider.getPost(int.parse(postId)),
            builder: (_, AsyncSnapshot<Post?> snapshot) {
              if (snapshot.hasData) {
                return PostDetail(post: snapshot.data);
              } else if (snapshot.hasError) {
                showToast(success: false, msg: '공유된 게시글을 찾을 수 없습니다.');
                Navigator.pop(context);
                return Container();
              } else {
                return Center(child: guamProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> _getShortLink(int id) async {
    String dynamicLinkPrefix = 'https://wafflestudio.page.link';
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('https://guam.wafflestudio.com/posts/$id'),
      androidParameters: AndroidParameters(
        //fallbackUrl: Uri.parse('https://guam.wafflestudio.com/posts/$id'), //앱이 없으면 웹(해당 라인 지우면 아마 구글 플레이 스토어로 리다이렉트)
        packageName: 'com.wafflestudio.guam_community',
        minimumVersion: 24,
      ),
      iosParameters: IOSParameters(
        //fallbackUrl: Uri.parse('https://guam.wafflestudio.com/posts/$id'),
        bundleId: 'com.wafflestudio.guam-community',
        minimumVersion: '12.0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: this.title != "" ? this.title : "IT 커뮤니티 : 괌(Guam)",
        imageUrl: Uri.parse("https://guam.wafflestudio.com/_next/static/media/favicon.e7a111af.svg"),
      ),
    );
    final unguessableDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );

    return unguessableDynamicLink.shortUrl.toString();
  }

  void share(int? id) async{
    if(!isLoading){
      isLoading = true;
      share_plus.Share.share(
        await _getShortLink(id!),
      ).then((value) {
        Future.delayed(Duration(milliseconds: 500),(){
          isLoading = false;
        });
      });
    }
  }
}
