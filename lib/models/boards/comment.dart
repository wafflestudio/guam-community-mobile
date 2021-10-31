import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/picture.dart';

class Comment extends ChangeNotifier {
  final int id;
  final String comment;
  final List<Picture> pictures;
  final int like;
  final DateTime createdAt;

  Comment({
    @required this.id,
    @required this.comment,
    this.pictures,
    this.like,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    List<Picture> pictures;

    if (json['pictures'] != null) {
      pictures = [...json['pictures'].map((picture) => Picture.fromJson({
        'id': picture['id'],
        'urlPath': picture['urlPath'],
      }))];
    }
    return Comment(
      id: json['id'],
      comment: json['comment'],
      pictures: pictures,
      like: json['like'],
      createdAt: json['createdAt'],
    );
  }
}
