import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/picture.dart';
import '../profiles/profile.dart';

class Message extends ChangeNotifier {
  final int id;
  final Profile profile; // 본인 및 상대방 프로필 겸용
  final bool isMe; // 나인지 아닌지
  final String content; // content==''일 땐 (즉, 사진만 보냄) '사진'으로 문구 대체할 예정
  final Picture picture;
  final DateTime createdAt;

  Message({
    this.id,
    this.profile,
    this.isMe,
    this.content,
    this.picture,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    Profile profile;
    Picture picture;

    if (json['profile'] != null) {
      profile = Profile.fromJson(json['profile']);
    }

    if (json['picture'] != null) {
      picture = Picture.fromJson(json['picture']);
    }

    return Message(
      id: json['id'],
      profile: profile,
      isMe: json['isMe'],
      content: json['content'],
      picture: picture,
      createdAt: json['createdAt'],
    );
  }
}
