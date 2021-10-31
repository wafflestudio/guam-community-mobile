import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/models/boards/comment.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String nickname;
  final String introduction;
  final String profileImageUrl;
  final String githubUrl;
  final String blogUrl;
  final List<dynamic> skillSet;
  final List<dynamic> interests;
  final List<Post> myPosts;
  final List<Post> scrappedPosts;
  final List<Comment> myComments;

  Profile({
    this.id,
    this.nickname,
    this.introduction,
    this.profileImageUrl,
    this.githubUrl,
    this.blogUrl,
    this.skillSet,
    this.interests,
    this.myPosts,
    this.scrappedPosts,
    this.myComments,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<Post> myPosts;
    List<Post> scrappedPosts;
    List<Comment> myComments;

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
      introduction: json['introduction'],
      profileImageUrl: json['profileImageUrl'],
      githubUrl: json['githubUrl'],
      blogUrl: json['blogUrl'],
      skillSet: json['skillSet'],
      interests: json['interests'],
      myPosts: myPosts,
      scrappedPosts: scrappedPosts,
      myComments: myComments,
    );
  }
}
