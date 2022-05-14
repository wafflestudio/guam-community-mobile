import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/messages/message.dart' as Message;
import '../profiles/profile.dart';

class MessageBox extends ChangeNotifier {
  final Profile otherProfile; // 상대방 프로필
  final Message.Message latestLetter; // 가장 마지막으로 보낸 메시지 (사진만 있는 경우 '사진'으로 보냄)

  MessageBox({
    this.otherProfile,
    this.latestLetter,
  });

  factory MessageBox.fromJson(Map<String, dynamic> json) {
    Profile otherProfile;
    Message.Message latestLetter;

    if (json['pair'] != null) {
      otherProfile = Profile.fromJson(json['pair']);
    }

    if (json['latestLetter'] != null) {
      latestLetter = Message.Message.fromJson(json['latestLetter']);
    }

    return MessageBox(
      otherProfile: otherProfile,
      latestLetter: latestLetter,
    );
  }
}
