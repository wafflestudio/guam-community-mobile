import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:guam_community_client/models/profiles/profile.dart';

class Comment extends ChangeNotifier {
  final int id;
  final Profile profile;
  final String content;
  final bool isLiked;
  final List<Picture> pictures;
  final List<dynamic> imagePaths; /// 임시 방편 (추후 pictures 활용 예정)
  final int likeCount;
  final String createdAt;

  Comment({
    this.id,
    this.profile,
    this.content,
    this.isLiked,
    this.pictures,
    this.imagePaths,
    this.likeCount,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    Profile profile;
    List<Picture> pictures;

    if (json['user'] != null) {
      profile = Profile.fromJson(json['user']);
    }

    if (json['pictures'] != null) {
      pictures = [...json['pictures'].map((picture) => Picture.fromJson({
        'id': picture['id'],
        'urlPath': picture['urlPath'],
      }))];
    }

    return Comment(
      id: json['id'],
      profile: profile,
      content: json['content'],
      isLiked: json['isLiked'],
      pictures: pictures,
      imagePaths: json['imagePaths'],
      likeCount: json['likeCount'],
      createdAt: json['createdAt'],
    );
  }
}
