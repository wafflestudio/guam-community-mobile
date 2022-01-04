import 'package:guam_community_client/models/profiles/profile.dart';

class Notification {
  final int id;
  final int postId;
  final int commentId; // commentId가 null이 아닌 경우 댓글에 관한 알림
  final bool isRead;
  final String comment;
  final String type;
  final Profile otherProfile;
  final DateTime createdAt;

  Notification({
    this.id,
    this.postId,
    this.commentId,
    this.isRead,
    this.comment,
    this.type,
    this.otherProfile,
    this.createdAt,
  });

  factory Notification.fromJson(dynamic json) {
    Profile otherProfile;

    if (json['otherProfile'] != null) {
      otherProfile = Profile.fromJson(json['otherProfile']);
    }

    return Notification(
      id: json['id'],
      postId: json['postId'],
      commentId: json['commentId'],
      isRead: json['isRead'],
      comment: json['comment'],
      type: json['type'],
      otherProfile: otherProfile,
      createdAt: json['createdAt'],
    );
  }
}
