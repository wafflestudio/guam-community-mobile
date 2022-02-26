import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:json_annotation/json_annotation.dart';
import '../picture.dart';
import './interest.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String nickname;
  final String intro;
  final String email;
  final Picture profileImg;
  final String githubId;
  final String blogUrl;
  final bool profileSet;
  final List<Interest> interests;

  // TODO: Remove from Profile attributes. Directly request at the view.
  final List<Post> myPosts;
  final List<Post> scrappedPosts;
  final List<Comment> myComments;

  Profile({
    this.id,
    this.nickname,
    this.intro,
    this.email,
    this.profileImg,
    this.githubId,
    this.blogUrl,
    this.profileSet,
    this.interests,
    this.myPosts,
    this.scrappedPosts,
    this.myComments,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<Interest> interests;
    Picture profileImg;
    List<Post> myPosts;
    List<Post> scrappedPosts;
    List<Comment> myComments;

    if (json["interests"] != null) {
      interests = [...json['interests'].map((i) => Interest(name: i['name']))];
    }

    if (json["profileImage"] != null) {
      profileImg = Picture.fromJson({
        "id": json["profileImage"]["id"],
        "urlPath": json["profileImage"]["urlPath"],
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
      intro: json['introduction'],
      email: json['email'],
      profileImg: profileImg,
      githubId: json['githubId'],
      blogUrl: json['blogUrl'],
      profileSet: json['profileSet'],
      interests: interests,
      myPosts: myPosts,
      scrappedPosts: scrappedPosts,
      myComments: myComments,
    );
  }

  /// flutter_mentions needs to have data as follows:
  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'display': nickname,
    'photo': profileImg != null
        ? profileImg.urlPath
        : null,
  };
}
