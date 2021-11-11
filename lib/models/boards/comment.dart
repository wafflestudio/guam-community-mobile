import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/picture.dart';
import 'package:guam_community_client/models/profile.dart';

class Comment extends ChangeNotifier {
  final int id;
  final Profile profile;
  final String comment;
  final bool isAuthor;
  final bool isLiked;
  final List<Picture> pictures;
  final int like;
  final DateTime createdAt;

  Comment({
    @required this.id,
    @required this.profile,
    @required this.comment,
    this.isAuthor,
    this.isLiked,
    this.pictures,
    this.like,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
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
    return Comment(
      id: json['id'],
      profile: profile,
      comment: json['comment'],
      isAuthor: json['isAuthor'],
      isLiked: json['isLiked'],
      pictures: pictures,
      like: json['like'],
      createdAt: json['createdAt'],
    );
  }
}
