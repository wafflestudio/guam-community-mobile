import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/models/picture.dart';
import '../profiles/profile.dart';

class Post extends ChangeNotifier {
  final int id;
  final Profile profile;
  final String boardType;
  final String title;
  final String content;
  final String category;
  final List<Picture> pictures;
  final List<Comment> comments;
  final int like;
  final int commentCnt;
  final int scrap;
  final bool isAuthor;
  final bool isLiked;
  final bool isScrapped;
  final DateTime createdAt;

  Post({
    this.id,
    this.profile,
    this.boardType,
    this.title,
    this.content,
    this.category,
    this.pictures,
    this.comments,
    this.like,
    this.commentCnt,
    this.scrap,
    this.isAuthor,
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
      'like': this.like,
      'createdAt': this.createdAt,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    Profile profile;
    List<Picture> pictures;
    List<Comment> comments;

    if (json['profile'] != null) {
      profile = Profile.fromJson(json['profile']);
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
      boardType: json['boardType'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      pictures: pictures,
      comments: comments,
      like: json['like'],
      commentCnt: json['commentCnt'],
      scrap: json['scrap'],
      isAuthor: json['isAuthor'],
      isLiked: json['isLiked'],
      isScrapped: json['isScrapped'],
      createdAt: json['createdAt'],
    );
  }
}
