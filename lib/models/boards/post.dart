import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/picture.dart';
import '../profile.dart';

class Post extends ChangeNotifier {
  final int id;
  final Profile profile;
  final String title;
  final String content;
  final String interest;
  final List<Picture> pictures;
  final int like;
  final int commentCnt;
  final int scrap;
  final bool isLiked;
  final bool isScrapped;
  final DateTime createdAt;

  Post({
    this.id,
    this.profile,
    this.title,
    this.content,
    this.interest,
    this.pictures,
    this.like,
    this.commentCnt,
    this.scrap,
    this.isLiked,
    this.isScrapped,
    this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    Profile profile;
    List<Picture> pictures;

    if (json['profile'] != null) {
      profile = Profile.fromJson(json['profile']);
    }

    if (json['pictures'] != null) {
      pictures = [...json['pictures'].map((picture) => Picture.fromJson({
        'id': picture['id'],
        'urlPath': picture['urlPath'],
      }))];
    }

    return Post(
      id: json['id'],
      profile: profile,
      title: json['title'],
      content: json['content'],
      interest: json['interest'],
      pictures: pictures,
      like: json['like'],
      commentCnt: json['commentCnt'],
      scrap: json['scrap'],
      isLiked: json['isLiked'],
      isScrapped: json['isScrapped'],
      createdAt: json['createdAt'],
    );
  }
}
