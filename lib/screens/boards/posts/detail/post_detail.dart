import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/common_text_field.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/boards/category.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/comments/comments.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_banner.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_body.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_more.dart';
import 'package:guam_community_client/screens/boards/posts/post_info.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../../../commons/functions_category_boardType.dart';
import '../../../../providers/messages/messages.dart';
import '../../../../providers/user_auth/authenticate.dart';

class PostDetail extends StatefulWidget {
  final int index;
  final Post post;
  final Function refreshPost;

  PostDetail({this.index, this.post, this.refreshPost});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> with Toast {
  Post _post;
  Future comments;
  bool commentImageExist = false;
  final int maxRenderImgCnt = 4;
  Set<int> mentionListId = {};
  List<Map<String, dynamic>> mentionList = [];
  List<Map<String, dynamic>> result = [];

  @override
  void initState() {
    _post = widget.post;
    mentionList = [_post.profile.toJson()];
    mentionListId = {_post.profile.id};
    comments = context.read<Posts>().fetchComments(_post.id);
    super.initState();
  }

  /// ????????? ?????? ???, API??? request??? Client??? ??????????????? ?????? ??? ?????? ?????? ?????? ?????? ??????
  /// ?????? ?????? ???????????? ??????????????? ?????? ?????? ?????? ??????????????? ??????.
  getEditedPost(Map editedPost) {
    if (editedPost == null) return;
    int editedBoardId = int.parse(editedPost['boardId']);
    int editedCategoryId = int.parse(editedPost['categoryId']);

    Category editedCategory = Category(
      postId: widget.post.id,
      categoryId: editedCategoryId,
      title: transferCategoryId(editedCategoryId),
    );

    setState(() {
      _post.title = editedPost['title'];
      _post.content = editedPost['content'];
      _post.boardType = transferBoardId(editedBoardId);
      _post.category = editedCategory;
    });
  }

  void addCommentImage() {
    setState(() => commentImageExist = true);
  }

  void removeCommentImage() {
    setState(() => commentImageExist = false);
  }

  @override
  void dispose() {
    mentionList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = context.watch<Posts>();
    Authenticate authProvider = context.read<Authenticate>();

    void fetchComments() {
      comments = postsProvider.fetchComments(_post.id);
    }

    Future createComment({Map<String, dynamic> fields, dynamic files}) async {
      return await postsProvider.createComment(
        postId: _post.id,
        fields: fields,
        files: files,
      ).then((successful) async {
        if (successful) fetchComments();
        Post _temp = await postsProvider.getPost(_post.id);
        _post.commentCount = _temp.commentCount;
        widget.refreshPost(widget.index, _temp);
        return successful;
      });
    }

    return Portal(
      child: Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          leading: Back(),
          trailing: Padding(
            padding: EdgeInsets.only(right: 11),
            child: Row(
              children: [
                if (widget.post.profile.id != 0)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/more.svg'),
                  onPressed: () => showModalBottomSheet(
                    /// DetailMore?????? Detail??? ????????? ????????? ?????? ?????????
                    context: context,
                    useRootNavigator: true,
                    builder: (_) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(create: (_) => Posts(authProvider)),
                          ChangeNotifierProvider(create: (_) => Messages(authProvider)),
                        ],
                        child: PostDetailMore(_post, getEditedPost)
                    ),
                    backgroundColor: GuamColorFamily.grayscaleWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
          onRefresh: () => context.read<Posts>().getPost(widget.post.id),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: commentImageExist ? 156 : 56,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostDetailBanner(_post),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 20),
                    child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
                  ),
                  PostDetailBody(_post),
                  Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 8),
                    child: PostInfo(
                      index: widget.index,
                      post: _post,
                      refreshPost: widget.refreshPost,
                      iconSize: 24,
                      showProfile: false,
                      iconColor: GuamColorFamily.grayscaleGray4,
                    ),
                  ),
                  CustomDivider(color: GuamColorFamily.grayscaleGray7),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: FutureBuilder(
                      /// FutureBuilder??? future??? ???????????? ????????? ????????? ???????????? ????????????
                      /// ????????? ??????????????? initState?????? ???????????????.
                      future: comments,
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.isNotEmpty) {
                            /// FutureBuilder??? snapshot?????? ?????? ?????? map?????? ????????????
                            /// Comment ??????????????? Provider??? ????????? ????????????
                            /// snapshot??? ?????? ???????????? ????????? ????????? ?????????.
                            void deleteComment(int commentId) {
                              setState(() {
                                snapshot.data.removeWhere((c) => c.id == commentId);
                              });
                            }
                            Future.delayed(
                              Duration.zero, () {
                                if (this.mounted)
                                  setState(() => snapshot.data.forEach((e) {
                                    if (!mentionListId.contains(e.profile.id))
                                      mentionList.add(e.profile.toJson());
                                    mentionListId.add(e.profile.id);
                                  }));
                              }
                            );
                            return Column(
                              children: [
                                ...snapshot.data.map((comment) => Comments(
                                  comment: comment,
                                  deleteFunc: deleteComment,
                                  isAuthor: _post.profile.id == comment.profile.id,
                                ))
                              ],
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: Center(
                                child: Text(
                                  "????????? ????????? ????????????.",
                                  style: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray5),
                                ),
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          showToast(success: true, msg: '??? ??? ?????? ????????? ??????????????????.');
                          return null;
                        } else {
                          return Center(child: CircularProgressIndicator(
                            color: GuamColorFamily.purpleLight3,
                          ));
                        }
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.black.withOpacity(0.3),
          child: CommonTextField(
            editTarget: null,
            onTap: createComment,
            mentionList: mentionList,
            addImage: addCommentImage,
            removeImage: removeCommentImage,
          ),
        ),
      ),
    );
  }
}
