import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Message extends ChangeNotifier {
  final int? id;
  final int? sentBy;
  final int? sentTo;
  final bool? isRead;
  final String? text;
  final String? imagePath;
  final String? createdAt;

  Message({
    this.id,
    this.sentBy,
    this.sentTo,
    this.isRead,
    this.text,
    this.imagePath,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sentBy: json['sentBy'],
      sentTo: json['sentTo'],
      isRead: json['isRead'],
      text: json['text'],
      imagePath: json['imagePath'],
      createdAt: json['createdAt'],
    );
  }
}
