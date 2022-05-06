import 'package:guam_community_client/models/profiles/profile.dart';

class Notification {
  final int id;
  final int userId;
  final String kind;
  final String body;
  final String linkUrl;
  final Profile writer;
  final bool isRead;
  final String createdAt;

  Notification({
    this.id,
    this.userId,
    this.kind,
    this.body,
    this.linkUrl,
    this.writer,
    this.isRead,
    this.createdAt,
  });

  factory Notification.fromJson(dynamic json) {
    Profile writer;

    if (json['writer'] != null) {
      writer = Profile.fromJson(json['writer']);
    }

    return Notification(
      id: json['id'],
      userId: json['userId'],
      kind: json['kind'],
      body: json['body'],
      linkUrl: json['linkUrl'],
      writer: writer,
      isRead: json['isRead'],
      createdAt: json['createdAt'],
    );
  }
}
