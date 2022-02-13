import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import '../picture.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String nickname;
  final String intro;
  final Picture profileImg;
  final String githubId;
  final String blogUrl;
  final List<dynamic> interests;
  final List<Post> myPosts;
  final List<Post> scrappedPosts;
  final List<Comment> myComments;

  Profile({
    this.id,
    this.nickname,
    this.intro,
    this.profileImg,
    this.githubId,
    this.blogUrl,
    this.interests,
    this.myPosts,
    this.scrappedPosts,
    this.myComments,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    Picture profileImg;
    List<Post> myPosts;
    List<Post> scrappedPosts;
    List<Comment> myComments;

    if (json["profileImg"] != null) {
      profileImg = Picture.fromJson({
        "id": json["profileImg"]["id"],
        "urlPath": json["profileImg"]["urlPath"],
      });
    }

    if (json['myPosts'] != null) {
      myPosts = [...json['myPosts'].map((post) => Post.fromJson({
        'id': post['id'],
        'title': post['title'],
        'content': post['content'],
        'like': post['like'],
        'scrap': post['scrap'],
        'createdAt': post['createdAt'],
      }))];
    }

    if (json['scrappedPosts'] != null) {
      scrappedPosts = [...json['scrappedPosts'].map((post) => Post.fromJson({
        'id': post['id'],
        'title': post['title'],
        'content': post['content'],
        'like': post['like'],
        'scrap': post['scrap'],
        'createdAt': post['createdAt'],
      }))];
    }

    if (json['myComments'] != null) {
      myComments = [...json['myComments'].map((comment) => Comment.fromJson({
        'id': comment['id'],
        'comment': comment['comment'],
        'like': comment['like'],
        'createdAt': comment['createdAt'],
      }))];
    }

    return Profile(
      id: json['id'],
      nickname: json['nickname'],
      intro: json['intro'],
      profileImg: profileImg,
      githubId: json['githubId'],
      blogUrl: json['blogUrl'],
      interests: json['interests'],
      myPosts: myPosts,
      scrappedPosts: scrappedPosts,
      myComments: myComments,
    );
  }
}
