import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/commons/functions_category_boardType.dart';
import 'package:guam_community_client/models/boards/category.dart' as Category;
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/models/picture.dart';
import '../profiles/profile.dart';

class Post extends ChangeNotifier {
  final int id;
  final String boardType; // ex) 익명, 홍보, 정보공유 게시판
  final Profile profile;
  final String title;
  final String content;
  final Category.Category category; // ex) 데이터분석, 개발, 디자인
  final List<Picture> pictures;
  final List<Comment> comments;
  final int likeCount;
  final int commentCount;
  final int scrapCount;
  final bool isImageIncluded;
  final bool isLiked;
  final bool isScrapped;
  final String createdAt;

  Post({
    this.id,
    this.profile,
    this.boardType,
    this.title,
    this.content,
    this.category,
    this.pictures,
    this.comments,
    this.likeCount,
    this.commentCount,
    this.scrapCount,
    this.isImageIncluded,
    this.isLiked,
    this.isScrapped,
    this.createdAt,
  });

  /*
  * Json Encoding for filter value comparison in search tab
  * */
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
    List<Picture> pictures;
    List<Comment> comments;

    // 추후 user와 profile 단어 괴리 맞추기
    if (json['user'] != null) {
      profile = Profile.fromJson(json['user']);
    }

    if (json['categories'] != null) {
      category = Category.Category.fromJson(json['categories']);
    }

    if (json['pictures'] != null) {
      pictures = [...json['pictures'].map((picture) => Picture.fromJson({
        'id': picture['id'],
        'urlPath': picture['urlPath'],
      }))];
    }

    if (json['comments'] != null) {
      comments = [...json['comments'].map((comment) => Comment.fromJson({
        'id': comment['id'],
        'profile': comment['profile'],
        'comment': comment['comment'],
        'pictures': comment['pictures'],
        'isAuthor': comment['isAuthor'],
        'isLiked': comment['isLiked'],
        'like': comment['like'],
      }))];
    }

    return Post(
      id: json['id'],
      profile: profile,
      boardType: transferBoardType(json['boardId']),
      title: json['title'],
      content: json['content'],
      category: category,
      pictures: pictures,
      comments: comments,
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      scrapCount: json['scrapCount'],
      isImageIncluded: json['isImageIncluded'],
      isLiked: json['isLiked'],
      isScrapped: json['isScrapped'],
      createdAt: json['createdAt'],
    );
  }
}
