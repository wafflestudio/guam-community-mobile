import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/profiles/profile.dart';

class Comment extends ChangeNotifier {
  final int id;
  final int postId;
  final Profile profile;
  final String content;
  final bool isMine;
  final bool isLiked;
  final List<dynamic> imagePaths; /// 임시 방편 (추후 pictures 활용 예정)
  final int likeCount;
  final String createdAt;

  Comment({
    this.id,
    this.postId,
    this.profile,
    this.content,
    this.isMine,
    this.isLiked,
    this.imagePaths,
    this.likeCount,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    Profile profile;

    if (json['user'] != null) {
      profile = Profile.fromJson(json['user']);
    }

    return Comment(
      id: json['id'],
      postId: json['postId'],
      profile: profile,
      content: json['content'],
      isMine: json['isMine'],
      isLiked: json['isLiked'],
      imagePaths: json['imagePaths'],
      likeCount: json['likeCount'],
      createdAt: json['createdAt'],
    );
  }
}
