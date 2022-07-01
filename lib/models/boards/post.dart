import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/commons/functions_category_boardType.dart';
import 'package:guam_community_client/models/boards/category.dart' as Category;
import 'package:guam_community_client/models/boards/comment.dart';
import '../profiles/profile.dart';

/// title, content, boardType, category는 게시글 수정 시 non-final로 정의
class Post extends ChangeNotifier {
  final int id;
  final Profile profile;
  final List<dynamic> imagePaths; // 서버 수정 전까지 쓰이는 임시방편 속성
  final List<Comment> comments;
  final bool isMine;
  final String createdAt;
  int boardId;
  String boardType; // ex) 익명, 홍보, 정보공유 게시판
  String title;
  String content;
  Category.Category category; // ex) 데이터분석, 개발, 디자인
  int likeCount;
  int commentCount;
  int scrapCount;
  bool isLiked;
  bool isScrapped;

  Post({
    this.id,
    this.profile,
    this.boardId,
    this.boardType,
    this.title,
    this.content,
    this.category,
    this.imagePaths,
    this.comments,
    this.likeCount,
    this.commentCount,
    this.scrapCount,
    this.isMine,
    this.isLiked,
    this.isScrapped,
    this.createdAt,
  });

  /// Json Encoding for filter value comparison in search tab
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'like': this.likeCount,
      'createdAt': this.createdAt,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    Profile profile;
    Category.Category category;
    List<Comment> comments;

    /**
     * Server에서 profile 대신 user라는 이름으로 주고 있는데,
     * 클라를 다 user로 고치든 서버에서 profile로 받아오든 할 것.
    **/
    if (json['user'] != null) {
      profile = Profile.fromJson(json['user']);
    }

    if (json['category'] != null) {
      category = Category.Category.fromJson(json['category']);
    }

    if (json['comments'] != null) {
      comments = [...json['comments'].map((comment) => Comment.fromJson({
        'id': comment['id'],
        'user': comment['user'],
        'content': comment['content'],
        'imagePaths': json['imagePaths'],
        'isLiked': comment['isLiked'],
        'likeCount': comment['likeCount'],
        'createdAt': json['createdAt'],
      }))];
    }

    return Post(
      id: json['id'],
      profile: profile,
      boardId: json['boardId'],
      boardType: transferBoardId(json['boardId']),
      title: json['title'],
      content: json['content'],
      category: category,
      imagePaths: json['imagePaths'],
      comments: comments,
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      scrapCount: json['scrapCount'],
      isMine: json['isMine'],
      isLiked: json['isLiked'],
      isScrapped: json['isScrapped'],
      createdAt: json['createdAt'],
    );
  }
}
